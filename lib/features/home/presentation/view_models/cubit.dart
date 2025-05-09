import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/home/data/repo/get_all_doctors_method.dart';
import 'package:nabd/features/home/presentation/view_models/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit of(BuildContext context) => BlocProvider.of(context);

  List<UserModel> doctorsList = [];
  Future<void> getDoctors() async {
    emit(GetAllDoctorsLoadingState());
    try {
      doctorsList = await GetAllDoctorsMethod.getDoctorsWithHighRating();
      emit(GetAllDoctorsSuccessState());
    } catch (e) {
      print('Error getting doctors: $e');
      emit(GetAllDoctorsErrorState());
    }
  }

  List<UserModel> searchAboutDoctorsList = [];

  Future<void> searchAboutDoctor({
    required String query,
    String filter = 'default', // default | specialty | rating
  }) async {
    emit(SearchAboutDoctorLoadingState());
    try {
      List<UserModel> list = await GetAllDoctorsMethod.getAllDoctors();
      query = query.toLowerCase().trim();

      searchAboutDoctorsList =
          list.where((doctor) {
            switch (filter) {
              case 'specialty':
                return doctor.specialty.toLowerCase().contains(query);

              case 'rating':
                return doctor.rating.toLowerCase().contains(query);

              default:
                return doctor.name.toLowerCase().contains(query);
            }
          }).toList();

      emit(SearchAboutDoctorSuccessState());
    } catch (e) {
      print('Error searching doctors: $e');
      emit(SearchAboutDoctorErrorState());
    }
  }
}
