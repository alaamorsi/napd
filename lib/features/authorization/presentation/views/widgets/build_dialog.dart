import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/features/authorization/presentation/view_models/guest_cubit/cubit.dart';
import 'package:nabd/features/authorization/presentation/view_models/guest_cubit/states.dart';
import 'package:nabd/features/layout/presentation/views/layout_screen.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';

class BuildDialog extends StatelessWidget {
  const BuildDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuestCubit(),
      child: BlocConsumer<GuestCubit, GuestStates>(
        listener: (context, state) {
          if (state is GuestLoginSuccessState) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LayoutScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 0.4.sh,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 20.0.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('تسجيل الدخول كـ زائر (مريض)', style: ConstantStyles.title),
                    SizedBox(height: 40.0.h),
                    state is GuestLoginLoadingState
                        ? const Center(
                          child: CircularProgressIndicator(
                            color: ConstantColors.primaryColor,
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(
                                  Size(120.0.w, 40.0.h),
                                ),
                                backgroundColor: const WidgetStatePropertyAll(
                                  Colors.red,
                                ),
                              ),
                              child: Text(
                                'إالغاء',
                                style: ConstantStyles.title.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                GuestCubit.of(context).loginAsGuest();
                              },
                              style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(
                                  Size(120.0.w, 40.0.h),
                                ),
                                backgroundColor: const WidgetStatePropertyAll(
                                  ConstantColors.primaryColor,
                                ),
                              ),
                              child: Text(
                                'اسمترار',
                                style: ConstantStyles.title.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
