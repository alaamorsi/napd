import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../widgets/build_dialog.dart';
import 'login_screen.dart';

class WhoAreYouScreen extends StatelessWidget {
  const WhoAreYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200.0.h,
              height: 200.0.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text('مرحبا بك في تطبيق نبض', style: ConstantStyles.title),
            SizedBox(height: 10.0.h),
            Text(
              'قم بتسجيل الدخول للاستمتاع بالميزات التي\n           !نقدمها، والبقاء بصحة جيدة',
              style: ConstantStyles.body,
            ),
            SizedBox(height: 50.0.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(160.0.w, 40.0.h)),
                backgroundColor: const WidgetStatePropertyAll(
                  ConstantColors.primaryColor,
                ),
              ),
              child: Text(
                'كـ طبيب',
                style: ConstantStyles.title.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0.h),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const BuildDialog(),
                );
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(160.0.w, 40.0.h)),
                side: const WidgetStatePropertyAll(
                  BorderSide(color: ConstantColors.primaryColor),
                ),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
              ),
              child: Text(
                'كـ زائر (مريض)',
                style: ConstantStyles.title.copyWith(
                  color: ConstantColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
