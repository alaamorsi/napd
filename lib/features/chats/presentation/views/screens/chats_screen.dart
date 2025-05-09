import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/view_models/states.dart';
import '../widgets/build_search_formfield.dart';
import '../widgets/build_chat_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (BuildContext context) =>
              CacheHelper.getData(key: 'userName') == 'Guest'
                  ? (ChatCubit()..getDoctors())
                  : (ChatCubit()..getClients()),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.of(context);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: BuildSearchFormField(hintText: 'بحث', chatCubit: cubit),
              ),
              SizedBox(height: 10.0.h),
              (state is GetClientsIdLoadingState ||
                      state is GetDoctorsIdLoadingState ||
                      state is SearchDoctorsLoadingState || state is SearchClientsLoadingState)
                  ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ConstantColors.primaryColor,
                      ),
                    ),
                  )
                  : (CacheHelper.getData(
                        key: 'userName',
                      ).toString().contains('Guest')
                      ? cubit.doctors.isEmpty
                      : cubit.clients.isEmpty)
                  ? Expanded(
                    child: Center(
                      child: Text('لا يوجد رسائل', style: ConstantStyles.body),
                    ),
                  )
                  : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemExtent: 80.0.h,
                      padding: EdgeInsets.zero,
                      itemBuilder:
                          (context, index) => BuildChatItem(
                            name:
                                CacheHelper.getData(
                                      key: 'userName',
                                    ).toString().contains('Guest')
                                    ? ChatCubit.of(context).doctors[index].name
                                    : ChatCubit.of(
                                      context,
                                    ).clients[index]['name'],
                            specialty:
                                CacheHelper.getData(
                                      key: 'userName',
                                    ).toString().contains('Guest')
                                    ? ChatCubit.of(
                                      context,
                                    ).doctors[index].specialty
                                    : '',
                            receiverId:
                                CacheHelper.getData(
                                      key: 'userName',
                                    ).toString().contains('Guest')
                                    ? cubit.doctors[index].uId
                                    : ChatCubit.of(
                                      context,
                                    ).clients[index]['uId'],
                            imageUrl:
                                CacheHelper.getData(
                                      key: 'userName',
                                    ).toString().contains('Guest')
                                    ? ChatCubit.of(context).doctors[index].image
                                    : 3,
                          ),
                      itemCount:
                          CacheHelper.getData(
                                key: 'userName',
                              ).toString().contains('Guest')
                              ? cubit.doctors.length
                              : cubit.clients.length,
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
