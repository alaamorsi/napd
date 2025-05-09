import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/constant_styles.dart';

class BuildTextformfield extends StatelessWidget {
  final String title;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final void Function()? suffixFunction;
  final TextEditingController controller;
  const BuildTextformfield(
      {super.key,
      required this.title,
      required this.prefixIcon,
      required this.validator,
      this.isPassword,
      this.suffixFunction,
      this.suffixIcon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: ConstantStyles.subtitle.copyWith(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        hintText: title,
        prefixIcon: Icon(
          prefixIcon,
          size: 25.0.r,
          color: Colors.grey,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(
                  suffixIcon,
                  size: 25.0.r,
                  color: Colors.grey,
                ),
              )
            : null,
        hintStyle: ConstantStyles.subtitle.copyWith(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xffF9FAFB),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.0.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide(width: 2.0.w, color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide(width: 2.0.w, color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide(width: 2.0.w, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide(width: 2.0.w, color: Colors.red),
        ),
      ),
    );
  }
}
