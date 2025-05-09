import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/features/search/presentation/view_model/cubit.dart';
import 'package:nabd/features/search/presentation/view_model/states.dart';

class BuildSearchFilter extends StatelessWidget {
  const BuildSearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.of(context);
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
                  Text(': البحث بواسطة', style: ConstantStyles.title),
                  SizedBox(height: 20.0.h),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.0.w,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (context, index) => ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: WidgetStatePropertyAll(0.0),
                                    shadowColor: WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(
                                      cubit.selectedFilterIndex == index
                                          ? ConstantColors.primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (index == 0) {
                                      cubit.changeSelectedFilter(
                                        'rating',
                                        index,
                                      );
                                    }
                                    if (index == 1) {
                                      cubit.changeSelectedFilter(
                                        'specialty',
                                        index,
                                      );
                                    }

                                    if (index == 2) {
                                      cubit.changeSelectedFilter(
                                        'default',
                                        index,
                                      );
                                    }
                                  },
                                  child: Text(
                                    cubit.filters[index],
                                    style: ConstantStyles.subtitle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            separatorBuilder:
                                (context, index) => SizedBox(width: 5.0.w),
                            itemCount: 3,
                          ),
                        ),
                      ],
                    ),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
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
