import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/core/utls/cache_helper.dart';

abstract class GetFcmToken {
  static Future<String> getUserToken(String receiverId) async {
    try {
      String userName;
      if (CacheHelper.getData(key: 'userName') == 'Guest') {
        userName = 'doctors';
      } else {
        userName = 'guests';
      }
      final userDoc =
          await FirebaseFirestore.instance
              .collection(userName)
              .doc(receiverId)
              .get();
      if (userDoc.exists) {
        return userDoc.data()?['fcmToken'];
      }
    } catch (e) {
      print('Error getting user token: $e');
    }
    return '';
  }
}
