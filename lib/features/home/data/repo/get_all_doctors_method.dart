import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';

abstract class GetAllDoctorsMethod {


  static Future<List<UserModel>> getAllDoctors() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('doctors').get() ;

      return querySnapshot.docs.map((doc) {
        final data = doc.data() ;
        return UserModel.fromJson(data);
      }).toList() ;
    } catch (e) {
      print('Error getting doctors: $e');
      return [];
    }
  }
  
  static Future<List<UserModel>> getDoctorsWithHighRating() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('doctors').get();

      final allDoctors = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson(data);
      }).toList();

      final filteredDoctors = allDoctors.where((doctor) {
        final doubleRating = double.tryParse(doctor.rating) ?? 0.0;
        return doubleRating >= 4.0 && doubleRating <= 5.0;
      }).toList();

      return filteredDoctors;
    } catch (e) {
      print('Error getting doctors with high rating: $e');
      return [];
    }
  }
}
