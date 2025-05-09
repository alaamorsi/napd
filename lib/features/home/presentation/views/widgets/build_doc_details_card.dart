import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';

class BuildDocDetailsCard extends StatelessWidget {
  final UserModel doctorModel;
  const BuildDocDetailsCard({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('د. ${doctorModel.name}', style: ConstantStyles.subtitle),
            Text(doctorModel.specialty, style: ConstantStyles.body),
            SizedBox(height: 10.0.h),
            Container(
              padding: EdgeInsets.all(4.0.w),
              decoration: BoxDecoration(
                color: ConstantColors.secondaryColor,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ConstantColors.primaryColor,
                    size: 18.0.r,
                  ),
                  SizedBox(width: 5.0.h),
                  Text(
                    doctorModel.rating,
                    style: ConstantStyles.body.copyWith(
                      color: ConstantColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 10.0.w),
        Container(
          width: 0.4.sw,
          height: 100.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0.r),
            image: DecorationImage(
              image:
                  doctorModel.image != 3
                      ? AssetImage(
                        ConstantVariables.profileimagesList[doctorModel.image],
                      )
                      : AssetImage(ConstantVariables.profileimagesList[0]),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
