import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/core/utils/bloc_observe.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/cubit.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/cubit.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_monitor_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_user_screen.dart';
import 'package:waqtii/features/authentication/splash/presentation/views/splash_screen.dart';

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
      ],
      child: MaterialApp(
        home: RegisterMonitorScreen(),
      ),
    );
  }
}
