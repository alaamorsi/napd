import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/features/authorization/data/repo/register/register_methods.dart';
import 'package:nabd/features/authorization/presentation/view_models/Register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>
    implements StateStreamable<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit of(BuildContext context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeSecure() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(RegisterChangeSecureState());
  }

  void registerProcess( String email, String password) {
    emit(RegisterProcessLoadinState());
    RegisterMethods.userRegister(email: email, password: password)
        .then((value) {
          if (value == true) {
            emit(RegisterProcessSuccessState());
          } else {
            emit(RegisterProcessErrorState());
          }
        })
        .catchError((error) {
          print(error);
          emit(RegisterProcessErrorState());
        });
  }
}
