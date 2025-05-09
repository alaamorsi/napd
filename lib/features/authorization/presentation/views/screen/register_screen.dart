import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/features/authorization/presentation/view_models/Register_cubit/states.dart';
import 'package:nabd/features/authorization/presentation/view_models/register_cubit/cubit.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../../../../../core/widgets/default_home_appbar.dart';
import '../widgets/build_login_with_google.dart';
import '../widgets/build_register_dialog.dart';
import '../widgets/build_textformfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(
        title: 'إنشاء حساب',
        canBack: true,
        backFunction: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterProcessSuccessState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const BuildRegisterDialog(),
              );
            } else if (state is RegisterProcessErrorState) {
              // You can also handle errors here
              Flushbar(
                title: 'خطأ',
                message: 'حدث خطأ أثناء التسجيل ',
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
                      // BuildTextformfield(
                      //   controller: nameController,
                      //   title: 'ادخل اسمك',
                      //   prefixIcon: Icons.person_outlined,
                      //   validator: (String? value) {
                      //     if (value!.isEmpty) {
                      //       return 'الرجاء ادخال الاسم';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: 20.0.h),
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
                        isPassword: RegisterCubit.of(context).isPassword,
                        suffixIcon: RegisterCubit.of(context).suffixIcon,
                        suffixFunction: RegisterCubit.of(context).changeSecure,
                      ),
                      SizedBox(height: 20.0.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.of(context).registerProcess(
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
                              state is RegisterProcessLoadinState
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'إنشاء حساب',
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
                              Navigator.pop(context);
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: ConstantStyles.body.copyWith(
                                color: ConstantColors.primaryColor,
                              ),
                            ),
                          ),
                          Text('لديك حساب بالفعل؟', style: ConstantStyles.body),
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
