import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/features/home/presentation/home_cubit/states.dart';
import 'package:waqtii/features/home_features/notes/presentation/views/notes_screen.dart';
import 'package:waqtii/features/home_features/pomodoro/presentation/views/pomodoro_screen.dart';
import 'package:waqtii/features/home_features/to_do/presentation/views/tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    TODOHome(),
    PomodoroScreen(),
    NotesScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Pomodoro',
    'Notes',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
