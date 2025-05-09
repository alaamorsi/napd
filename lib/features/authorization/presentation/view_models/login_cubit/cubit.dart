import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/features/authorization/data/repo/login/login_methods.dart';
import 'package:nabd/features/authorization/data/repo/reset/reset_methods.dart';
import 'package:nabd/features/authorization/presentation/view_models/login_cubit/states.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit of(BuildContext context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeSecure() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(LoginChangeSecureState());
  }

  void loginProcess(String email, String password) {
    emit(LoginProcessLoadingState());
    LoginMethods.userLogin(email: email, password: password)
        .then((value) async {
          if (value == true) {
            await ProfileCubit().getUserData();
            emit(LoginProcessSuccessState());
          } else {
            emit(LoginProcessErrorState());
          }
        })
        .catchError((error) {
          emit(LoginProcessErrorState());
        });
  }

  Future<void> resetPassword(String email) async {
    emit(ResetForgotPasswordLoadingState());
    await ResetMethods.sendPasswordResetEmail(email)
        .then((value) {
          emit(ResetForgotPasswordSuccessState());
        })
        .catchError((error) {
          emit(ResetForgotPasswordErrorState());
        });
  }
}
