import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/profile/data/repo/user_data_methods.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit of(BuildContext context) => BlocProvider.of(context);
  Future<void> getUserData() async {
    emit(ProfileGetUserDataLoadinState());
    try {
      UserModel userModelBox = await UserDataMethods.getData();
      var userBox = Hive.box<UserModel>('userModel');

      await userBox.put('userModel', userModelBox);
      ConstantVariables.userData = userBox.get('userModel');
      emit(ProfileGetUserDataSuccessState());
    } catch (e) {
      print(e);
      emit(ProfileGetUserDataErrorState());
    }
  }

  Future<void> updateUserData({
    String? name,
    String? about,
    String? specialty,
    int? image,
  }) async {
    emit(ProfileUpdateUserDataLoadinState());
    try {
      await UserDataMethods.updateData(
        uId: ConstantVariables.uId,
        name: name,
        about: about,
        specialty: specialty,
        image: image,
      );
      emit(ProfileUpdateUserDataSuccessState());
    } catch (e) {
      print(e);
      emit(ProfileUpdateUserDataErrorState());
    }
  }

  int? selectImage;

  void selectImageMethod(int index) {
    selectImage = index;
    emit(ProfileSelectImageState());
  }
}
