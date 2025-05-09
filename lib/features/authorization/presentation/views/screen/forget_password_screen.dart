import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../../../../../core/widgets/default_home_appbar.dart';
import '../../view_models/login_cubit/cubit.dart';
import '../../view_models/login_cubit/states.dart';
import '../widgets/build_textformfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(
        title: 'إعادة تعيين كلمة المرور',
        canBack: true,
        backFunction: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) async {
            if (state is ResetForgotPasswordSuccessState) {
              await Flushbar(
                title: 'نجاح',
                message:
                    'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                icon: Icon(Icons.check, color: Colors.white),
              ).show(context);

              if (context.mounted) {
                Navigator.pop(context);
              }
            } else if (state is ResetForgotPasswordErrorState) {
              await Flushbar(
                title: 'خطأ',
                message: 'خطأ في إرسال رابط إعادة تعيين كلمة المرور',
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                icon: Icon(Icons.error, color: Colors.white),
              ).show(context);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.of(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('نسيت كلمة المرور؟', style: ConstantStyles.title),
                      SizedBox(height: 10.0.h),
                      Text(
                        'إذا كنت قد نسيت كلمة المرور، أدخل بريدك الإلكتروني وسنرسل لك\nرابطًا لإعادة تعيينها.',
                        style: ConstantStyles.body,
                        textDirection: TextDirection.rtl,
                      ),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await cubit.resetPassword(emailController.text);
                              await Future.delayed(Duration(seconds: 3));
                            } else {
                              return;
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
                              state is ResetForgotPasswordLoadingState
                                  ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(
                                    'إرسال',
                                    style: ConstantStyles.title.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
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
