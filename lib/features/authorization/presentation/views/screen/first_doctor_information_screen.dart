import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/core/widgets/default_home_appbar.dart';
import 'package:nabd/features/layout/presentation/views/layout_screen.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';
import 'package:nabd/features/profile/presentation/views/widgets/build_profile_edit_textformfield.dart';

class FirstDoctorInformationScreen extends StatefulWidget {
  const FirstDoctorInformationScreen({super.key});

  @override
  State<FirstDoctorInformationScreen> createState() =>
      _FirstDoctorInformationScreenState();
}

class _FirstDoctorInformationScreenState
    extends State<FirstDoctorInformationScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController aboutController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  String selectedSpecialty = 'القلب';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(title: 'معلوماتك الاساسية', canBack: false),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildProfileEditTextformfield(
                  nameController: nameController,
                  aboutController: aboutController,
                ),
                SizedBox(height: 20.0),
                Text('التخصص', style: ConstantStyles.title),
                SizedBox(height: 10.0.h),
                DropdownButtonFormField2<String>(
                  isDense: false,
                  alignment: Alignment.centerLeft,
                  style: ConstantStyles.subtitle.copyWith(color: Colors.black),
                  iconStyleData: const IconStyleData(
                    iconEnabledColor: Colors.black,
                  ),
                  value: selectedSpecialty,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    contentPadding: EdgeInsets.only(right: 5.0.w, top: 15.0.h),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0.h),
                BlocProvider(
                  create: (context) => ProfileCubit(),
                  child: BlocConsumer<ProfileCubit, ProfileStates>(
                    listener: (context, state) async {
                      if (state is ProfileUpdateUserDataSuccessState) {
                        await Flushbar(
                          title: 'نجاح',
                          message: 'تم حفظ المعلومات بنجاح',
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3),
                          flushbarPosition: FlushbarPosition.TOP,
                          margin: EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(8),
                          icon: const Icon(Icons.check, color: Colors.white),
                        ).show(context);
                        AppNavigator.pushAndRemoveUntil(LayoutScreen());
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (fromKey.currentState!.validate()) {
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
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'حفظ المعلومات',
                                    style: ConstantStyles.title.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 70.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
