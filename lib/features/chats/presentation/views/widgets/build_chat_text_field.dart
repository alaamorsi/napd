import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';

class BuildChatTextField extends StatefulWidget {
  final String receiverId;
  final String name;
  final int imageUrl;
  const BuildChatTextField({super.key, required this.receiverId, required this.name, required this.imageUrl});

  @override
  State<BuildChatTextField> createState() => _BuildChatTextFieldState();
}

class _BuildChatTextFieldState extends State<BuildChatTextField> {
  bool isTyping = false;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0.h,
      left: 0.0.w,
      right: 0.0.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 120.0.h,
                  minHeight: 40.0.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.w,
                  vertical: 5.0.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0.w, color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: TextFormField(
                  onChanged: (String? value) {
                    if (value!.trim().isNotEmpty) {
                      setState(() {
                        isTyping = true;
                      });
                    } else {
                      setState(() {
                        isTyping = false;
                      });
                    }
                  },
                  controller: messageController,
                  // textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  autocorrect: true,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  cursorColor: ConstantColors.primaryColor,
                  style: ConstantStyles.subtitle,
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك هنا',
                    hintStyle: ConstantStyles.body,
                    border: InputBorder.none,
                    isCollapsed: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            isTyping
                ? Row(
                  children: [
                    SizedBox(width: 10.0.w),
                    Container(
                      width: 50.0.w,
                      height: 50.0.w,
                      decoration: const BoxDecoration(
                        color: ConstantColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final chatCubit = ChatCubit.of(context);
                          String message = messageController.text.trim();
                          messageController.clear();
                          setState(() {
                            isTyping = false;
                          });
                          await chatCubit.sendMessage(
                            widget.receiverId,
                            message,
                            widget.name,
                            widget.imageUrl,
                          );

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (chatCubit.scrollController.hasClients) {
                              chatCubit.scrollController.animateTo(
                                chatCubit
                                    .scrollController
                                    .position
                                    .maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        },
                        icon: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
