import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/images/constant_images.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/view_models/states.dart';

import '../../../../../core/styles/constant_styles.dart';
import '../screens/chat_details_screen.dart';

class BuildChatItem extends StatelessWidget {
  final String name;
  final String specialty;
  final int imageUrl;
  final String receiverId;
  const BuildChatItem({
    super.key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            final chatCubit = BlocProvider.of<ChatCubit>(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider.value(
                      value: chatCubit,
                      child: ChatDetailsScreen(
                        name: name,
                        receiverId: receiverId,
                        imageUrl: imageUrl,
                      ),
                    ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CacheHelper.getData(key: 'userName') == 'doctor'
                              ? Text(name, style: ConstantStyles.subtitle)
                              : Text('د/ $name', style: ConstantStyles.subtitle),
                          Text(specialty, style: ConstantStyles.body),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0.w),
                    Container(
                      width: 75.w,
                      height: 75.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1.0.w),
                        image: DecorationImage(
                          image:
                              imageUrl != 3
                                  ? AssetImage(
                                    ConstantVariables
                                        .profileimagesList[imageUrl],
                                  )
                                  : AssetImage(ConstantImages.guest),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
