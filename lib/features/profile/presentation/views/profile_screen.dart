import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';
import 'package:nabd/features/profile/presentation/views/widgets/build_profile_details.dart';
import 'package:nabd/features/profile/presentation/views/widgets/build_profile_edits_buttons.dart';
import '../../../../core/colors/constant_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        ConstantColors.primaryColor,
                        ConstantColors.secondaryColor,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30.0.r,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0.h),
                      BuildProfileDetails(
                        model: ConstantVariables.userData!,
                      ),
                      SizedBox(height: 20.0.h),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0.r),
                              topRight: Radius.circular(30.0.r),
                            ),
                          ),
                          child: const BuildProfileEditsButtons(),
                        ),
                      ),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}
