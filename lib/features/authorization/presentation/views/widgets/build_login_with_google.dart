import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/presentation/view_models/google_cubit/cubit.dart';
import 'package:nabd/features/authorization/presentation/view_models/google_cubit/states.dart';
import 'package:nabd/features/authorization/presentation/views/screen/first_doctor_information_screen.dart';
import 'package:nabd/features/layout/presentation/views/layout_screen.dart';

import '../../../../../core/styles/constant_styles.dart';

class BuildLoginWithGoogle extends StatelessWidget {
  const BuildLoginWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 1.0.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            SizedBox(width: 10.0.w),
            Text('او', style: ConstantStyles.body),
            SizedBox(width: 10.0.w),
            Expanded(
              child: Container(
                height: 1.0.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0.h),
        BlocProvider(
          create: (context) => GoogleCubit(),
          child: BlocConsumer<GoogleCubit, GoogleStates>(
            listener: (context, state) {
              if (state is LoginWithGoogleProcessSuccessState) {
                if (ConstantVariables.userData!.specialty.isEmpty) {
                  AppNavigator.pushReplacement(FirstDoctorInformationScreen());
                } else {
                  AppNavigator.pushReplacement(LayoutScreen());
                }
              } else if (state is LoginWithGoogleProcessErrorState) {
                Flushbar(
                  title: 'خطأ',
                  message: 'حدث خطأ أثناء تسجيل الدخول',
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8),
                  icon: Icon(Icons.error, color: Colors.white),
                ).show(context);
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    GoogleCubit.of(context).loginWithGoogle();
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50.0.h),
                    ),
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Colors.grey.shade300),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  ),
                  child:
                      state is LoginWithGoogleProcessLoadinState
                          ? CircularProgressIndicator(
                            color: ConstantColors.primaryColor,
                          )
                          : Row(
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 20.0.h,
                                width: 20.0.w,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'تسجيل الدخول بحساب جوجل',
                                    style: ConstantStyles.subtitle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
