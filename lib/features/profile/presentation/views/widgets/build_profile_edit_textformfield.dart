import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';

class BuildProfileEditTextformfield extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController aboutController;
  const BuildProfileEditTextformfield({
    super.key,
    required this.nameController,
    required this.aboutController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('الاسم', style: ConstantStyles.title),
        SizedBox(height: 10.0.h),
        TextFormField(
          controller: nameController,
          textDirection: TextDirection.rtl,
    
          style: ConstantStyles.subtitle.copyWith(color: Colors.black),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^[\u0600-\u06FF\s]+$'),
            ),
          ],
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الاسم';
            } else if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value)) {
              return 'يرجى إدخال حروف عربية فقط';
            }
            return null;
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'الاسم',
            hintStyle: ConstantStyles.subtitle.copyWith(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.0.w,
              vertical: 15.0.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(
                width: 1.0.w,
                color: ConstantColors.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0.h),
        Text('نبذة عنك', style: ConstantStyles.title),
        SizedBox(height: 10.0.h),
        Container(
          constraints: BoxConstraints(
            maxHeight: 150.0.h, 
          ),
          child: TextFormField(
            controller: aboutController,
            textDirection: TextDirection.rtl,
            style: ConstantStyles.subtitle.copyWith(color: Colors.black),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن أن يكون هذا الحقل فارغاً';
              }
              return null;
            },
            cursorColor: Colors.black,
            maxLines: null, // يسمح بعدد غير محدود من الأسطر
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'نبذة عنك',
              hintStyle: ConstantStyles.subtitle.copyWith(
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
                vertical: 15.0.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
                borderSide: BorderSide(
                  width: 1.0.w,
                  color: ConstantColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
