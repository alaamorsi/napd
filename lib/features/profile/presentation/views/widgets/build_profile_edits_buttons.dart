import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../profile_editing_screen.dart';

class BuildProfileEditsButtons extends StatelessWidget {
  const BuildProfileEditsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.h, vertical: 30.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              AppNavigator.pushReplacement(
                ProfileEditingScreen(
                  name: ConstantVariables.userData!.name,
                  specialty: ConstantVariables.userData!.specialty,
                  about: ConstantVariables.userData!.about,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0.r),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الملف الشخصي',
                      style: ConstantStyles.title.copyWith(color: Colors.black),
                    ),
                    Text(
                      'تعديل الملف الشخصي',
                      style: ConstantStyles.body.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 15.0.w),
                Container(
                  width: 50.0.w,
                  height: 50.0.w,
                  decoration: const BoxDecoration(
                    color: ConstantColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 30.0.r,
                    color: ConstantColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
