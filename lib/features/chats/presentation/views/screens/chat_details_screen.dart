import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/chats/data/models/message_model.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/view_models/states.dart';
import 'package:nabd/features/chats/presentation/views/widgets/build_chat_text_field.dart';
import 'package:nabd/features/chats/presentation/views/widgets/build_pop_menu.dart';

import '../../../../../core/widgets/default_home_appbar.dart';
import '../widgets/build_message_card.dart';

class ChatDetailsScreen extends StatelessWidget {
  final String name;
  final String receiverId;
  final int imageUrl;
  const ChatDetailsScreen({
    super.key,
    required this.name,
    required this.receiverId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(
        title:
            CacheHelper.getData(key: 'userName').toString() == 'Guest'
                ? 'د. $name'
                : name,
        canBack: true,
        backFunction: () {
          ChatCubit.of(context).getDoctors().then((_) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          });
        },
        actionWidget:
            CacheHelper.getData(key: 'userName').toString() == 'Guest'
                ? PopupMenuButton<String>(
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 30.0.r,
                  ),
                  onSelected: (value) {
                    if (value == 'تقييم') {
                      var cubit = ChatCubit.of(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return BlocProvider.value(
                            value: cubit,
                            child: BuildPopMenu(receiverId: receiverId),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => [
                        PopupMenuItem(
                          value: 'تقييم',
                          child: Text('تقييم', style: ConstantStyles.subtitle),
                        ),
                      ],
                  offset: Offset(
                    0,
                    40,
                  ), // This moves the menu down by 40 pixels
                )
                : null,
      ),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.of(context);
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<MessageModel>>(
                        stream: cubit.getMessagesStream(
                          CacheHelper.getData(key: 'userName') == 'Guest'
                              ? ConstantVariables.guestuId
                              : ConstantVariables.uId,
                          receiverId,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting &&
                              !snapshot.hasData) {
                            return Container(); // Show nothing while waiting
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }
                          final messages = snapshot.data!;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (cubit.scrollController.hasClients) {
                              cubit.scrollController.animateTo(
                                cubit.scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                          return ListView.separated(
                            key: const PageStorageKey<String>(
                              'chat_messages_list',
                            ),
                            controller: cubit.scrollController,
                            shrinkWrap: true,
                            itemBuilder:
                                (context, index) => BuildMessageCard(
                                  message: messages[index].message,
                                  time: messages[index].time,
                                  senderId: messages[index].senderId,
                                ),
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20.0.h),
                            itemCount: messages.length,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 60.0.h),
                  ],
                ),
              ),
              BuildChatTextField(
                receiverId: receiverId,
                name: name,
                imageUrl: imageUrl,
              ),
            ],
          );
        },
      ),
    );
  }
}
