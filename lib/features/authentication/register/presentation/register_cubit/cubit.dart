import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/features/authentication/register/domain/models/register_monitor_model.dart';
import 'package:waqtii/features/authentication/register/domain/models/register_user_model.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;

  bool isPass = true;

  void changePassVis() {
    isPass = !isPass;
    suffixIcon =
        isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeIconPassState());
  }

  var selectedGender;

  void changeGender(value) {
    selectedGender = value;
    emit(RegisterChangeGenderState());
  }

  RegisterUserModel? userModel;

  void userRegister({
    required String fullName,
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required String gender,
  }) {
    emit(RegisterUserLoadingState());

    ApiService.postData(url: 'signup/', data: {
      'fullName': fullName,
      'email': email,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'gender': gender,
    }).then((value) {
      userModel = RegisterUserModel.fromJson(value?.data);

      emit(RegisterUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(RegisterUserErrorState(error.toString()));
    });
  }

  MonitorData? monitorData;

  void monitorRegister({
    required String fullName,
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required String gender,
    required String linkedin,
    required String github,
  }) {
    emit(RegisterMonitorLoadingState());

    ApiService.postData(url: 'signup/', data: {
      'fullName': fullName,
      'email': email,
      'password': password,
      'userName': userName,
      'phone': phoneNumber,
      'gender': gender,
      'linkedin': linkedin,
      'github': github,
    }).then((value) {
      monitorData = MonitorData.fromJson(value?.data);

      emit(RegisterMonitorSuccessState());
    }).catchError((error) {
      emit(RegisterMonitorErrorState(error.toString()));
    });
  }
}
