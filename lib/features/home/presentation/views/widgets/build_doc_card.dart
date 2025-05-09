import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../screens/doctor_details_screen.dart';

class BuildDocCard extends StatelessWidget {
  final UserModel doctorModel;
  const BuildDocCard({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(doctorModel: doctorModel),
          ),
        );
      },
      child: Container(
        width: 0.40.sw,
        height: 180.h,
        padding: EdgeInsets.all(10.0.w),
        margin: EdgeInsets.only(right: 10.0.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ConstantColors.primaryColor, width: 1.0.w),
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75.w,
              height: 75.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image:
                      doctorModel.image != 3
                          ? AssetImage(
                            ConstantVariables.profileimagesList[doctorModel
                                .image],
                          )
                          : AssetImage(ConstantVariables.profileimagesList[0]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  'د. ${doctorModel.name}',
                  style: ConstantStyles.subtitle,
                ),
              ),
            ),
            SizedBox(height: 5.0.h),
            Text(doctorModel.specialty, style: ConstantStyles.body),
            SizedBox(height: 10.0.h),
            Container(
              decoration: BoxDecoration(
                color: ConstantColors.secondaryColor,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: ConstantColors.primaryColor,
                    size: 20.0.r,
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
      ),
    );
  }
}
