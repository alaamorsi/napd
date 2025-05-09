import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatGetClients {
  static Future<List<Map<String, dynamic>>> getClientsInfo(
    String userId,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final docSnapshot = await firestore.collection('doctors').doc(userId).get();

    if (!docSnapshot.exists) return [];

    final data = docSnapshot.data() as Map<String, dynamic>;
    final List<String> clientIds = List<String>.from(data['clientsId'] ?? []);

    if (clientIds.isEmpty) return [];

    // Fetch all guest docs in parallel
    final futures =
        clientIds.map((clientId) async {
          final doc = await firestore.collection('guests').doc(clientId).get();
          if (!doc.exists) return null;

          final guestData = doc.data();
          final name = guestData?['name'] ?? '';
          final uId = guestData?['uId'] ?? '';
          return {'name': name, 'uId': uId};
        }).toList();

    final results = await Future.wait(futures);

    // Remove any null entries (in case some docs didn't exist)
    return results.whereType<Map<String, dynamic>>().toList();
  }
}
