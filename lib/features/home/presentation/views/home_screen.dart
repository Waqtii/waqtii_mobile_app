import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/features/home/presentation/home_cubit/cubit.dart';
import 'package:waqtii/features/home/presentation/home_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: cubit.screens[1],
            bottomNavigationBar: FlashyTabBar(
              selectedIndex: cubit.currentIndex,
              onItemSelected: (index) {
                cubit.changeIndex(index);
              },
              items: [
                FlashyTabBarItem(
                  title: const Text('Tasks'),
                  icon: const Image(
                    width: 25,
                    image: AssetImage('assets/icons/Tasks.png'),
                  ),
                ),
                FlashyTabBarItem(
                    title: const Text('Pomodoro'),
                    icon: const Image(
                      width: 25,
                      image: AssetImage('assets/icons/Pomodoro.png'),
                    )),
                FlashyTabBarItem(
                    title: const Text('Notes'),
                    icon: const Image(
                      width: 25,
                      image: AssetImage('assets/icons/Notes.png'),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
