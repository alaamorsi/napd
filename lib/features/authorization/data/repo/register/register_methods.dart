import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterMethods {
  static Future<bool> userRegister({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      return true;
    } catch (error) {
      print('##########################################');
      print(error);
      return false;
    }
  }
}
