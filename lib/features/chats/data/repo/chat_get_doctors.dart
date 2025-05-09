import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorInfo {
  final String name;
  final String specialty;
  final String about;
  final int image;
  final String uId;
  DoctorInfo({
    required this.name,
    required this.image,
    required this.uId,
    required this.specialty,
    required this.about,
  });
}

abstract class ChatGetDoctorsStates {
  static Future<List<DoctorInfo>> getDoctorsInfo(String guestId) async {
    final firestore = FirebaseFirestore.instance;

    // Step 1: Get guest document
    final guestDoc = await firestore.collection('guests').doc(guestId).get();

    if (!guestDoc.exists) return [];

    final data = guestDoc.data() as Map<String, dynamic>;
    final List<String> doctorIds = List<String>.from(data['doctorsId'] ?? []);

    if (doctorIds.isEmpty) return [];

    // Step 2: Fetch all doctors' documents in parallel
    final futures =
        doctorIds
            .map((id) => firestore.collection('doctors').doc(id).get())
            .toList();

    final snapshots = await Future.wait(futures);

    // Step 3: Extract name and image from each doctor document
    return snapshots.where((doc) => doc.exists).map((doc) {
      final docData = doc.data() as Map<String, dynamic>;
      final name = docData['name'] ?? '';
      final image = docData['image'] ?? 3;
      final uId = docData['uId'] ?? '';
      final specialty = docData['specialty'] ?? '';
      final about = docData['about'] ?? '';
      return DoctorInfo(
        name: name,
        image: image,
        uId: uId,
        specialty: specialty,
        about: about,
      );
    }).toList();
  }
}
