import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';
import 'package:nabd/features/profile/presentation/views/widgets/build_profile_image.dart';
import '../../../../../core/styles/constant_styles.dart';

class BuildProfileDetails extends StatelessWidget {
  final UserModel model;
  const BuildProfileDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            BuildProfileImage(),
            SizedBox(height: 20.0.h),
            Text(
              'د. ${model.name}',
              style: ConstantStyles.subtitle.copyWith(color: Colors.white),
            ),
            SizedBox(height: 20.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, size: 24.0.r, color: Colors.white),
                    SizedBox(height: 7.0.h),
                    Text(
                      'معدل التقييم',
                      style: ConstantStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      model.rating,
                      style: ConstantStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 30.0.w),
                Container(width: 1.0.w, height: 50.0.h, color: Colors.white),
                SizedBox(width: 30.0.w),
                Column(
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 24.0.r,
                      color: Colors.white,
                    ),
                    SizedBox(height: 7.0.h),
                    Text(
                      'التخصص',
                      style: ConstantStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      model.specialty,
                      style: ConstantStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
