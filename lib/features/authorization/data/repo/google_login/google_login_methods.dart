import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/repo/login/login_methods.dart';
import 'package:nabd/features/authorization/data/repo/login/save_fcm_token_method.dart';

abstract class GoogleLoginMethods {
  static Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // Create a credential using the Google authentication tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Check if the user is already registered in Firestore
      final userDoc =
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(userCredential.user!.uid)
              .get();

      if (!userDoc.exists) {
        // User not registered, create a new user in Firestore
        LoginMethods.userCreate(
          name: gUser.displayName ?? '',
          specialty: '',
          email: gUser.email,
          image: 3,
          uId: userCredential.user!.uid,
        );
      }
      CacheHelper.saveData(
        key: 'uId',
        value: userCredential.user!.uid,
      ); // Save user ID in cache
      CacheHelper.saveData(key: 'userName', value: 'doctor');
      ConstantVariables.uId = userCredential.user!.uid;
      await SaveFcmTokenMethod.getFcmTokenAndSaveIt();

      return userCredential;
    } catch (error) {
      rethrow;
    }
  }
}
