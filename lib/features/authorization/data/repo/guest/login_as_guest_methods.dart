import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/repo/login/save_fcm_token_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class LoginAsGuestProcess {
  static Future<void> loginGuest() async {
    final deviceId = await getDeviceId();
    final guestsRef = FirebaseFirestore.instance.collection('guests');

    // Step 1: Check Firestore for a guest with this deviceId
    final matchingGuests =
        await guestsRef.where('deviceId', isEqualTo: deviceId).get();

    String uid;

    if (matchingGuests.docs.isNotEmpty) {
      // Device already registered as guest
      final existingGuest = matchingGuests.docs.first;
      uid = existingGuest['uId'];

      print('Logged in with existing guest profile');
    } else {
      // Step 2: New guest
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      uid = userCredential.user!.uid;

      final guestCountSnapshot = await guestsRef.get();
      final nextGuestNumber = guestCountSnapshot.docs.length + 1;
      final guestName = 'كـ زائر $nextGuestNumber (مريض $nextGuestNumber)';

      await guestsRef.doc(uid).set({
        'deviceId': deviceId,
        'name': guestName,
        'uId': uid,
        'doctorsId': <String>[],
      });

      print('New guest created');
    }

    // Save UID locally
    ConstantVariables.guestuId = uid;
    CacheHelper.saveData(key: 'guestuId', value: uid);
    CacheHelper.saveData(key: 'userName', value: 'Guest');
        await SaveFcmTokenMethod.getFcmTokenAndSaveIt();
  }

  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to read the saved ID first
    String? savedId = prefs.getString('device_id');
    if (savedId != null) return savedId;

    final deviceInfo = DeviceInfoPlugin();

    String deviceId;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // or androidInfo.androidId
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor!;
    } else {
      deviceId = const Uuid().v4(); // fallback
    }

    // Save the device ID for later use
    await prefs.setString('device_id', deviceId);
    return deviceId;
  }
}
