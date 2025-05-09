import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/search/presentation/view_model/cubit.dart';

class BuildSearchFormField extends StatelessWidget {
  final ChatCubit? chatCubit;
  final SearchCubit? searchCubit;
  final String? filter; // default | specialty | rating
  final TextEditingController searchController = TextEditingController();
  final String hintText;
  BuildSearchFormField({
    super.key,
    required this.hintText,
    this.filter,
    this.chatCubit,
    this.searchCubit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (String? value) {
        if (chatCubit != null) {
          CacheHelper.getData(key: 'userName') == 'doctor'
              ? chatCubit!.searchChatClients(query: searchController.text)
              : chatCubit!.searchChatDoctors(query: searchController.text);
        }
        if (searchCubit != null) {
          searchCubit!.searchAboutDoctor(
            query: searchController.text,
            filter: filter ?? 'default',
          );
        }
      },
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black38),
        prefixIcon: IconButton(
          onPressed: () {
            if (chatCubit != null) {
              CacheHelper.getData(key: 'userName') == 'doctor'
                  ? chatCubit!.searchChatClients(query: searchController.text)
                  : chatCubit!.searchChatDoctors(query: searchController.text);
            }
            if (searchCubit != null) {
              searchCubit!.searchAboutDoctor(
                query: searchController.text,
                filter: filter ?? 'default',
              );
            }
          },
          icon: Icon(Icons.search, color: Colors.black38, size: 24.0.r),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(width: 1.0.w, color: Colors.black38),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(width: 1.5.w, color: Colors.black),
        ),
      ),
    );
  }
}
