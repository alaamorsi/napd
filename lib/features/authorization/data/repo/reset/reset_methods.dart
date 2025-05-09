import 'package:firebase_auth/firebase_auth.dart';

abstract class ResetMethods {
 static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
    } catch (e) {
      print('Failed to send password reset email: $e');
    }
  }

  Future<void> verifyPasswordResetCode(String code) async {
    try {
      String email = await FirebaseAuth.instance.verifyPasswordResetCode(code);
      print('Code verified for email: $email');
    } catch (e) {
      print('Failed to verify reset code: $e');
    }
  }

  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      print('Password has been reset');
    } catch (e) {
      print('Failed to reset password: $e');
    }
  }
}
