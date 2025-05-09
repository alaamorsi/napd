import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/features/authorization/data/repo/google_login/google_login_methods.dart';
import 'package:nabd/features/authorization/presentation/view_models/google_cubit/states.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';

class GoogleCubit extends Cubit<GoogleStates> {
  GoogleCubit() : super(LoginWithGoogleInitialState());
  static GoogleCubit of(BuildContext context) => BlocProvider.of(context);

  Future<void> loginWithGoogle() async {
    emit(LoginWithGoogleProcessLoadinState());
    try {
      await GoogleLoginMethods.signInWithGoogle();
      await ProfileCubit().getUserData();

      emit(LoginWithGoogleProcessSuccessState());
    } catch (e) {
      print(e.toString());
      emit(LoginWithGoogleProcessErrorState());
    }
  }
}
