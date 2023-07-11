import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/features/home/presentation/home_cubit/cubit.dart';
import 'package:waqtii/features/home/presentation/home_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Tasks',
                icon: Image(
                  width: 25,
                  image: AssetImage('assets/icons/Tasks.png'),
                ),
              ),
              BottomNavigationBarItem(
                  label: 'Pomodoro',
                  icon: Image(
                    width: 25,
                    image: AssetImage('assets/icons/Pomodoro.png'),
                  )),
              BottomNavigationBarItem(
                  label: 'Notes',
                  icon: Image(
                    width: 25,
                    image: AssetImage('assets/icons/Notes.png'),
                  )),
            ],
          ),
        );
      },
    );
  }
}
