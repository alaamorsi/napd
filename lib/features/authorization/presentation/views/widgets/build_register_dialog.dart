import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';

class BuildRegisterDialog extends StatelessWidget {
  const BuildRegisterDialog({super.key});

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 0.5.sh,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 20.0.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تم إنشاء الحساب بنجاح!',
                    textDirection: TextDirection.rtl,
                    style: ConstantStyles.title,
                  ),
                  SizedBox(height: 15.0.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100.0.h,
                        height: 100.0.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ConstantColors.secondaryColor,
                        ),
                      ),
                      Container(
                        width: 40.0.h,
                        height: 40.0.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/success.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0.h),
                  Text(
                    'لإكمال عملية التسجيل، يرجى فتح البريد الإلكتروني الذي أدخلته والضغط على رابط التفعيل. بعد التحقق، يمكنك تسجيل الدخول والاستمتاع بتجربتك معنا!',
                    style: ConstantStyles.body,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 20.0.h),
                  ElevatedButton(
                    onPressed: () {
                     Navigator.pop(context);
                      // Navigate to login screen or perform any other action
                     Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(160.0.w, 40.0.h)),
                      backgroundColor: const WidgetStatePropertyAll(
                        ConstantColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      'تسجيل الدخول',
                      style: ConstantStyles.title.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
