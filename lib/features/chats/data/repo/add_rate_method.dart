import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/features/chats/data/models/rate_model.dart';

abstract class AddRateMethod {
  static Future<void> addRateMethod({
    required String receiverId,
    required RateModel rateModel,
  }) async {
    try {
      DocumentReference doctorRef = FirebaseFirestore.instance
          .collection('doctors')
          .doc(receiverId);

      DocumentSnapshot doctorSnapshot = await doctorRef.get();

      if (!doctorSnapshot.exists) {
        print('Doctor not found');
        return;
      }

      Map<String, dynamic> data = doctorSnapshot.data() as Map<String, dynamic>;

      List<dynamic> existingRatesRaw = data['rates'] ?? [];

      List<RateModel> existingRates =
          existingRatesRaw.map((e) => RateModel.fromJson(Map<String, dynamic>.from(e))).toList();

      // Check if the user already rated
      int existingIndex = existingRates.indexWhere(
        (r) => r.senderId == rateModel.senderId,
      );

      if (existingIndex != -1) {
        existingRates[existingIndex] = rateModel;
      } else {
        existingRates.add(rateModel);
      }

      // Calculate weighted rating (smart)
      double total = 0;
      double totalWeight = 0;

      for (int i = 0; i < existingRates.length; i++) {
        double weight = 1 + (i / existingRates.length); // more recent = more weight
        double value = double.tryParse(existingRates[i].rate) ?? 0;

        total += value * weight;
        totalWeight += weight;
      }

      double finalRating = totalWeight == 0 ? 0 : total / totalWeight;

      // Update Firestore
      await doctorRef.update({
        'rates': existingRates.map((e) => e.toJson()).toList(),
        'rating': finalRating.toString(),
      });

      print('Rate added/updated with smart rating ✅');
    } catch (error) {
      print('Failed to add/update rate: $error');
    }
  }
}