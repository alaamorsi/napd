import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget; // <--- instead of icon + iconFunction
  final bool canBack;
  final void Function()? backFunction;

  const DefaultAppbar({
    super.key,
    required this.title,
    this.actionWidget,
    required this.canBack,
    this.backFunction,
  });

  @override
  Size get preferredSize => Size.fromHeight(100.0.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.0.h,
      backgroundColor: Colors.white,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        if (actionWidget != null) actionWidget!,
      ],
      leading: canBack
          ? IconButton(
              onPressed: backFunction,
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30.0.r),
            )
          : null,
    );
  }
}