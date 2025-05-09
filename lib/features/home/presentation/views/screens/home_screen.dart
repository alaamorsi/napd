import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/features/home/presentation/view_models/cubit.dart';
import 'package:nabd/features/home/presentation/view_models/states.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/styles/constant_styles.dart';
import '../widgets/build_ad_card.dart';
import '../widgets/build_doc_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getDoctors(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is GetAllDoctorsLoadingState,
            ignoreContainers: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const BuildAdCard(),
                SizedBox(height: 50.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('اعلى الاطباء تقييماً', style: ConstantStyles.title),
                    ],
                  ),
                ),
                SizedBox(height: 20.0.h),
                SizedBox(
                  width: double.infinity,
                  height: 180.0.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => BuildDocCard(
                          doctorModel: HomeCubit.of(context).doctorsList[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0.w),
                    itemCount: HomeCubit.of(context).doctorsList.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
