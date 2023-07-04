import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/features/authentication/login/domain/models/login_model.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;

  bool isPass = true;

  void changePassVis() {
    isPass = !isPass;
    suffixIcon =
        isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeIconPassState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    ApiService.postData(url: 'login/', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value?.data.runtimeType);
      loginModel = LoginModel.fromJson(value?.data);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}
