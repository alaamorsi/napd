import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/view_models/states.dart';

class BuildPopMenu extends StatefulWidget {
  final String receiverId;
  const BuildPopMenu({super.key, required this.receiverId});

  @override
  State<BuildPopMenu> createState() => _BuildPopMenuState();
}

class _BuildPopMenuState extends State<BuildPopMenu> {
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          if (state is AddRateSuccessState) {
            Navigator.pop(context);
            Flushbar(
              title: 'تقييم',
              message: 'تم تقييم الطبيب بنجاح',
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              margin: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              icon: Icon(Icons.check, color: Colors.white),
            ).show(context);
          } else if (state is AddRateErrorState) {
            Navigator.pop(context);
            Flushbar(
              title: 'تقييم',
              message: 'حدث خطأ أثناء تقييم الطبيب',
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              margin: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              icon: Icon(Icons.error, color: Colors.white),
            ).show(context);
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 0.4.sh,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: ConstantColors.primaryColor,
                          size: 40.0.r,
                        ),
                        onPressed: () {
                          selectedRating = index + 1;
                          (context as Element)
                              .markNeedsBuild(); // Forces the widget to rebuild
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 20.0.h),
                  Text(
                    'هل ترغب في تقييم هذا الطبيب؟',
                    style: ConstantStyles.subtitle,
                  ),
                  SizedBox(height: 20.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'إلغاء',
                          style: ConstantStyles.subtitle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.primaryColor,
                        ),
                        onPressed: () async {
                          await ChatCubit.of(context).addRateMethod(
                            widget.receiverId,
                            selectedRating.toString(),
                          );
                        },
                        child:
                            state is AddRateLoadingState
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'تأكيد',
                                  style: ConstantStyles.subtitle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
