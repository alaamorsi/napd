import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/widgets/logout_widget.dart';
import 'package:nabd/features/profile/presentation/views/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (CacheHelper.getData(key: 'userName') != 'Guest')
            InkWell(
              onTap: () {
                AppNavigator.push(ProfileScreen());
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
                        'معلومات الملف الشخصي',
                        style: ConstantStyles.title.copyWith(
                          color: Colors.black,
                        ),
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
          if (CacheHelper.getData(key: 'userName') != 'Guest')
            SizedBox(height: 20.0.h),
          LogoutWidget(),
        ],
      ),
    );
  }
}
