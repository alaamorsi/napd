import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/constant_colors.dart';
import '../../../../core/widgets/default_home_appbar.dart';
import '../view_models/cubit.dart';
import '../view_models/states.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = LayoutCubit.of(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: DefaultAppbar(
                      title: cubit.listAppBars[cubit.currentIndex]['title'],
                      canBack: false,
                    ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 10.0,
                selectedItemColor: ConstantColors.primaryColor,
                unselectedItemColor: Colors.black38,
                items: List.generate(
                  cubit.items.length,
                  (index) => BottomNavigationBarItem(
                    icon: cubit.icons[index],
                    label: cubit.items[index],
                  ),
                ),
                currentIndex: cubit.currentIndex,
                onTap: cubit.changeNavBar,
              ),
            );
          }),
    );
  }
}
