import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ConstantStyles {
  static TextStyle title = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle subtitle = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle body = TextStyle(
      fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w500);
}
