import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';

abstract class SaveFcmTokenMethod {
  static Future<void> getFcmTokenAndSaveIt() async {
    try {
      // Get the FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        CacheHelper.getData(key: 'userName') == 'doctor'
            ? await FirebaseFirestore.instance
                .collection('doctors')
                .doc(ConstantVariables.uId)
                .update({'fcmToken': fcmToken})
            : await FirebaseFirestore.instance
                .collection('guests')
                .doc(ConstantVariables.guestuId)
                .update({'fcmToken': fcmToken});

        print('FCM Token saved successfully: $fcmToken');
      } else {
        print('Failed to get FCM Token or User ID is null');
      }
    } catch (e) {
      print('Error saving FCM Token: $e');
    }
  }
}
