import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/utls/cache_helper.dart';
import '../../../../../core/variables/constant_variables.dart';

abstract class LogoutMethods {
  void userLogOut() {
    FirebaseAuth.instance.signOut().then((value) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        CacheHelper.removeData(key: 'uId');
        ConstantVariables.uId = '';
      });
    }).catchError((error) {});
  }
}
