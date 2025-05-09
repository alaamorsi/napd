import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/utls/format_time.dart';
import 'package:nabd/core/variables/constant_variables.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';

class BuildMessageCard extends StatelessWidget {
  final String message;
  final Timestamp time;
  final String senderId;
  const BuildMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return senderId ==
            (CacheHelper.getData(key: 'userName') == 'Guest'
                ? ConstantVariables.guestuId
                : ConstantVariables.uId)
        ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0.w),
              constraints: BoxConstraints(
                maxWidth: 0.5.sw - 10.0.w,
                minWidth: 0.25.sw + 30.0.w,
                minHeight: 50.0.h,
              ),
              decoration: BoxDecoration(
                color: ConstantColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0.r),
                  bottomRight: Radius.circular(10.0.r),
                  bottomLeft: Radius.circular(10.0.r),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text(message, style: ConstantStyles.subtitle),
                      SizedBox(height: 10.0.h),
                    ],
                  ),
                  Positioned(
                    right: 0.0.w,
                    bottom: 0.0.h,
                    child: Text(
                      FormatTime.formatTime(time),
                      style: ConstantStyles.body.copyWith(
                        color: Colors.black,
                        fontSize: 10.5.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10.0.w),
              constraints: BoxConstraints(
                maxWidth: 0.5.sw - 10.0.w,
                minWidth: 0.25.sw + 30.0.w,
                minHeight: 50.0.h,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0.r),
                  bottomRight: Radius.circular(10.0.r),
                  bottomLeft: Radius.circular(10.0.r),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text(message, style: ConstantStyles.subtitle),
                      SizedBox(height: 10.0.h),
                    ],
                  ),
                  Positioned(
                    right: 0.0.w,
                    bottom: 0.0.h,
                    child: Text(
                      FormatTime.formatTime(time),
                      style: ConstantStyles.body.copyWith(
                        color: Colors.black,
                        fontSize: 10.5.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
