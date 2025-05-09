import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/features/chats/presentation/views/widgets/build_search_formfield.dart';
import 'package:nabd/features/home/presentation/views/widgets/build_doc_card.dart';
import 'package:nabd/features/search/presentation/view_model/cubit.dart';
import 'package:nabd/features/search/presentation/view_model/states.dart';
import 'package:nabd/features/search/presentation/views/widgets/build_search_filter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (BuildContext context) => SearchCubit()..searchAboutDoctor(query: '',),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.of(context);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: BuildSearchFormField(
                        hintText: 'ابحث',
                        searchCubit: cubit,
                        filter: cubit.selectedFilter,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return BlocProvider.value(
                            value: cubit,
                            child: BuildSearchFilter(),
                          );
                        },
                      );
                      },
                      padding: EdgeInsets.only(left: 5.0.w),
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.tune,
                        size: 38.0.r,
                        color: ConstantColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
                Expanded(
                  child:
                      cubit.searchAboutDoctorsList.isEmpty &&
                              state is! SearchAboutDoctorLoadingState
                          ? Center(
                            child: Text(
                              'لا يوجد',
                              style: ConstantStyles.title.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : state is SearchAboutDoctorLoadingState
                          ? Center(
                            child: CircularProgressIndicator(
                              color: ConstantColors.primaryColor,
                            ),
                          )
                          : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: cubit.searchAboutDoctorsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // عدد الأعمدة
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3 / 4, // العرض إلى الطول
                                ),
                            itemBuilder:
                                (context, index) => BuildDocCard(
                                  doctorModel:
                                      cubit.searchAboutDoctorsList[index],
                                ),
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
