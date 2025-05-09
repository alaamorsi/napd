import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/features/layout/presentation/view_models/states.dart';
import 'package:nabd/features/settings/presentation/views/settings_screen.dart';

import '../../../chats/presentation/views/screens/chats_screen.dart';
import '../../../home/presentation/views/screens/home_screen.dart';
import '../../../search/presentation/views/screens/search_screen.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitialLayoutState()) {
    _initializeLayout();
  }

  static LayoutCubit of(context) => BlocProvider.of(context);

  List<String> items = [];
  List<Widget> icons = [];
  List<Widget> screens = [];
  List<Map<String, dynamic>> listAppBars = [];

  int currentIndex = 0;

  void _initializeLayout() {
    final isGuest = CacheHelper.getData(key: 'userName') == 'doctor';

    if (isGuest) {
      items = ['الرسائل', 'الاعدادات'];
      icons = [
        Icon(Icons.chat, size: 24.0.r),
        Icon(Icons.settings, size: 24.0.r),
      ];
      screens = [const ChatsScreen(), const SettingsScreen()];
      listAppBars = [
        {'title': 'الرسائل', 'icon': null},
        {'title': 'اعدادات', 'icon': null},
      ];
    } else {
      items = ['الصفحة الرئيسية', 'البحث', 'الرسائل', 'الاعدادات'];
      icons = [
        Icon(Icons.home, size: 24.0.r),
        Icon(Icons.search, size: 24.0.r),
        Icon(Icons.chat, size: 24.0.r),
        Icon(Icons.settings, size: 24.0.r),
      ];
      screens = [
        const HomeScreen(),
        const SearchScreen(),
        const ChatsScreen(),
        const SettingsScreen(),
      ];
      listAppBars = [
        {
          'title': 'صحتك أولويتنا \n تواصل مع أفضل الأطباء في أي وقت',
          'icon': Icons.notifications,
        },
        {
          'title': 'ابحث عن الطبيب\nالذي تريد ان يساعدك',
          'icon': Icons.notifications,
        },
        {'title': 'الرسائل', 'icon': null},
        {'title': 'اعدادات', 'icon': null},
      ];
    }
  }

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarLayoutState());
  }
}
