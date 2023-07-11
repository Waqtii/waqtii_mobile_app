import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/constants.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/core/utils/bloc_observe.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/cubit.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/cubit.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_user_screen.dart';
import 'package:waqtii/features/home/presentation/home_cubit/cubit.dart';
import 'package:waqtii/features/home/presentation/views/home_screen.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';

void main() {
  ApiService.init();
  Bloc.observer = MyBlocObserver();
  runApp(const WaqtiiApp());
}

class WaqtiiApp extends StatelessWidget {
  const WaqtiiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => TODOCubit()..getTasks()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeManager.lightTheme(),
        home: HomeScreen(),
      ),
    );
  }
}
