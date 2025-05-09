import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/authorization/data/repo/login/save_fcm_token_method.dart';

import '../../../../../core/utls/cache_helper.dart';
import '../../../../../core/variables/constant_variables.dart';

abstract class LoginMethods {
  static Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.emailVerified) {
        CacheHelper.saveData(key: 'uId', value: userCredential.user!.uid);
        ConstantVariables.uId = userCredential.user!.uid;
        CacheHelper.saveData(key: 'userName', value: 'doctor');
        final userDoc =
            await FirebaseFirestore.instance
                .collection('doctors')
                .doc(userCredential.user!.uid)
                .get();

        if (!userDoc.exists) {
          // User not registered, create a new user in Firestore
          LoginMethods.userCreate(
            name: userCredential.user!.displayName ?? '',
            specialty: '',
            email: email,
            image: 3,
            uId: userCredential.user!.uid,
          );
        }
        await SaveFcmTokenMethod.getFcmTokenAndSaveIt();

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static void userCreate({
    required String name,
    required String specialty,
    required String email,
    int image = 3,
    String rate = '0.0',
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      specialty: specialty,
      email: email,
      image: image,
      about: '',
      uId: uId,
      clientsId: [],
      rates: [],
      rating: '0.0',
    );
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {})
        .catchError((error) {});
  }
}
