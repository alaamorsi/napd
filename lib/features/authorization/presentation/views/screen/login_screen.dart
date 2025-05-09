import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/presentation/views/screen/first_doctor_information_screen.dart';
import 'package:nabd/features/authorization/presentation/views/screen/register_screen.dart';
import 'package:nabd/features/authorization/presentation/views/screen/who_are_you_screen.dart';
import 'package:nabd/features/layout/presentation/views/layout_screen.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../../../../../core/widgets/default_home_appbar.dart';
import '../../view_models/login_cubit/cubit.dart';
import '../../view_models/login_cubit/states.dart';
import '../widgets/build_login_with_google.dart';
import '../widgets/build_textformfield.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(
        title: 'تسجيل الدخول',
        canBack: true,
        backFunction: () {
          AppNavigator.pushReplacement(WhoAreYouScreen());
        },
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginProcessSuccessState) {
              if (ConstantVariables.userData!.specialty.isEmpty) {
                AppNavigator.pushReplacement(FirstDoctorInformationScreen());
              }
              AppNavigator.pushReplacement(LayoutScreen());
            } else if (state is LoginProcessErrorState) {
              Flushbar(
                title: 'خطأ',
                message: 'خطأ في تسجيل الدخول',
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
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      BuildTextformfield(
                        controller: emailController,
                        title: 'ادخل البريد الإلكتروني',
                        prefixIcon: Icons.email_outlined,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'الرجاء ادخال البريد الإلكتروني';
                          } else if (!value.contains('@')) {
                            return 'الرجاء ادخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0.h),
                      BuildTextformfield(
                        controller: passwordController,
                        title: 'ادخل كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'الرجاء ادخال كلمة المرور';
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب ان تكون اكثر من 6 احرف';
                          }
                          return null;
                        },
                        isPassword: LoginCubit.of(context).isPassword,
                        suffixIcon: LoginCubit.of(context).suffixIcon,
                        suffixFunction: LoginCubit.of(context).changeSecure,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: ConstantStyles.body.copyWith(
                                color: ConstantColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.of(context).loginProcess(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(
                              Size(double.infinity, 50.0.h),
                            ),
                            backgroundColor: const WidgetStatePropertyAll(
                              ConstantColors.primaryColor,
                            ),
                          ),
                          child:
                              state is LoginProcessLoadingState
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'تسجيل الدخول',
                                    style: ConstantStyles.title.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'سجل الآن',
                              style: ConstantStyles.body.copyWith(
                                color: ConstantColors.primaryColor,
                              ),
                            ),
                          ),
                          Text('ليس لديك حساب؟', style: ConstantStyles.body),
                        ],
                      ),
                      const BuildLoginWithGoogle(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
