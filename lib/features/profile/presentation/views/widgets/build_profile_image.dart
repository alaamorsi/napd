import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/profile/presentation/view_models/cubit.dart';
import 'package:nabd/features/profile/presentation/view_models/states.dart';

class BuildProfileImage extends StatelessWidget {
  const BuildProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) async {
        var cubit = ProfileCubit.of(context);

        if (state is ProfileUpdateUserDataSuccessState) {
          await cubit.getUserData();

          if (context.mounted) {
            Navigator.pop(context);
            Flushbar(
              title: 'تحديث الصورة الشخصية',
              message: 'تم تحديث الصورة بنجاح',
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              margin: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              icon: Icon(Icons.check, color: Colors.white),
            ).show(context);
          }
        } else if (state is ProfileUpdateUserDataErrorState) {
          if (context.mounted) {
            Flushbar(
              title: 'تحديث الصورة الشخصية',
              message: 'فشل تحديث الصورة',
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              margin: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              icon: Icon(Icons.error, color: Colors.white),
            ).show(context);
          }
        }
      },

      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120.0.h,
              height: 120.0.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image:
                      ConstantVariables.userData!.image != 3
                          ? AssetImage(
                            ConstantVariables
                                .profileimagesList[ConstantVariables
                                .userData!
                                .image],
                          )
                          : AssetImage(ConstantVariables.profileimagesList[0]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 38.0.w,
              width: 38.0.w,
              decoration: const BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  var cubit = ProfileCubit.of(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return BlocProvider.value(
                        value: cubit, // 👈 خد نفس instance اللي موجود فوق
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                          ),
                          child: BlocBuilder<ProfileCubit, ProfileStates>(
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
                                      Text(
                                        ': اختر الصورة',
                                        style: ConstantStyles.title,
                                      ),
                                      SizedBox(height: 20.0.h),
                                      Expanded(
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (context, index) => InkWell(
                                                onTap: () {
                                                  cubit.selectImageMethod(
                                                    index,
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius:
                                                      ProfileCubit.of(
                                                                context,
                                                              ).selectImage ==
                                                              index
                                                          ? 47.5.r
                                                          : 37.5.r,
                                                  backgroundColor:
                                                      ConstantColors
                                                          .primaryColor,
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                      milliseconds: 100,
                                                    ),
                                                    width: 75.0.h,
                                                    height: 75.0.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          ConstantColors
                                                              .secondaryColor,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          ConstantVariables
                                                              .profileimagesList[index],
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          separatorBuilder:
                                              (context, index) =>
                                                  SizedBox(width: 10.0.w),
                                          itemCount: 3,
                                        ),
                                      ),
                                      SizedBox(height: 20.0.h),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await ProfileCubit.of(
                                            context,
                                          ).updateUserData(
                                            image:
                                                ProfileCubit.of(
                                                  context,
                                                ).selectImage,
                                          );
                                        },
                                        style: ButtonStyle(
                                          fixedSize: WidgetStatePropertyAll(
                                            Size(120.0.w, 40.0.h),
                                          ),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                ConstantColors.primaryColor,
                                              ),
                                        ),
                                        child:
                                            state is ProfileUpdateUserDataLoadinState
                                                ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                                : Text(
                                                  'تأكيد',
                                                  style: ConstantStyles.title
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 24.r,
                  color: ConstantColors.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
