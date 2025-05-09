// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';
import 'package:nabd/features/profile/presentation/views/profile_screen.dart';
import 'package:nabd/features/profile/presentation/views/widgets/build_profile_edit_textformfield.dart';
import '../../../../core/colors/constant_colors.dart';
import '../../../../core/styles/constant_styles.dart';
import '../../../../core/widgets/default_home_appbar.dart';

class ProfileEditingScreen extends StatefulWidget {
  final String name;
  final String about;
  final String? specialty;
  const ProfileEditingScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.about,
  });

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  late String selectedSpecialty;
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  final List<String> specialties = [
    "القلب",
    "العيون",
    "الاسنان",
    "الاطفال",
    "الباطنة",
    "الجلدية",
    "النساء والتوليد",
    "العظام",
    "الاعصاب",
    "المخ والاعصاب",
  ];
  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    aboutController.text = widget.about;
    selectedSpecialty =
        widget.specialty == '' ? specialties[0] : widget.specialty!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppbar(
        title: 'تعديل معلومات الملف الشخصي',
        canBack: true,
        backFunction: () {
          AppNavigator.pushReplacement(ProfileScreen());
        },
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is ProfileUpdateUserDataSuccessState) {
              Flushbar(
                title: 'تحديث البيانات',
                message: 'تم تحديث البيانات بنجاح',
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                flushbarPosition: FlushbarPosition.TOP,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                icon: Icon(Icons.check, color: Colors.white),
              ).show(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Form(
                key: fromKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BuildProfileEditTextformfield(
                        nameController: nameController,
                        aboutController: aboutController,
                      ),
                      SizedBox(height: 20.0.h),
                      Text('التخصص', style: ConstantStyles.title),
                      SizedBox(height: 10.0.h),
                      DropdownButtonFormField2<String>(
                        isDense: false,
                        alignment: Alignment.centerLeft,
                        style: ConstantStyles.subtitle.copyWith(
                          color: Colors.black,
                        ),
                        iconStyleData: const IconStyleData(
                          iconEnabledColor: Colors.black,
                        ),
                        value: selectedSpecialty,
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          contentPadding: EdgeInsets.only(
                            right: 5.0.w,
                            top: 15.0.h,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            borderSide: BorderSide(
                              width: 1.0.w,
                              color: ConstantColors.primaryColor,
                            ),
                          ),
                        ),
                        hint: const Text("اختر التخصص"),
                        items:
                            specialties.map((String specialty) {
                              return DropdownMenuItem<String>(
                                value: specialty,
                                child: Text(specialty),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSpecialty = newValue!;
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300.h,
                          elevation: 2,
                          offset: const Offset(0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 100.0.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (fromKey.currentState!.validate()) {
                              if (nameController.text.trim() !=
                                      widget.name.trim() ||
                                  aboutController.text.trim() !=
                                      widget.about.trim() ||
                                  selectedSpecialty != widget.specialty) {
                                await ProfileCubit.of(context).updateUserData(
                                  name: nameController.text,
                                  about: aboutController.text,
                                  specialty: selectedSpecialty,
                                );
                                ConstantVariables.userData!.name =
                                    nameController.text;
                                ConstantVariables.userData!.about =
                                    aboutController.text;
                                ConstantVariables.userData!.specialty =
                                    selectedSpecialty;
                                await ConstantVariables.userData!.save();
                              } else {
                                Flushbar(
                                  title: 'تحديث البيانات',
                                  message: 'لا يوجد أي تغييرات',
                                  backgroundColor: Colors.amber,
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  margin: EdgeInsets.all(8),
                                  borderRadius: BorderRadius.circular(8),
                                  icon: Icon(Icons.error, color: Colors.white),
                                ).show(context);
                              }
                            }
                          },
                          style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(
                              Size(160.0.w, 40.0.h),
                            ),
                            backgroundColor: const WidgetStatePropertyAll(
                              ConstantColors.primaryColor,
                            ),
                          ),
                          child:
                              state is ProfileUpdateUserDataLoadinState
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                    'حفظ التغييرات',
                                    style: ConstantStyles.title.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 70.0.h),
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
