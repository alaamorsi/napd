import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/authorization/presentation/views/screen/login_screen.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        ConstantVariables.uId = '';
        await CacheHelper.removeData(key: 'uId');
        await CacheHelper.removeData(key: 'userName');
        await Hive.box<UserModel>('userModel').clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.arrow_back_ios, color: Colors.red, size: 20.0.r),
          const Spacer(),
          Text(
            'تسجيل الخروج',
            style: ConstantStyles.title.copyWith(color: Colors.red),
          ),
          SizedBox(width: 15.0.w),
          Container(
            width: 50.0.w,
            height: 50.0.w,
            decoration: const BoxDecoration(
              color: ConstantColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.logout_outlined, size: 30.0.r, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
