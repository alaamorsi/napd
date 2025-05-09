import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/features/authorization/data/repo/guest/login_as_guest_methods.dart';
import 'package:nabd/features/authorization/presentation/view_models/guest_cubit/states.dart';

class GuestCubit extends Cubit<GuestStates> {
  GuestCubit() : super(GuestInitialState());
  static GuestCubit of(BuildContext context) => BlocProvider.of(context);

  Future<void> loginAsGuest() async {
    try {
      emit(GuestLoginLoadingState());
      await LoginAsGuestProcess.loginGuest();
      Future.delayed(const Duration(seconds: 2), () {
        emit(GuestLoginSuccessState());
      });
    } catch (e) {
      print('###########################');
      print(e);
      print('###########################');
      emit(GuestLoginErrorState());
    }
  }
}
