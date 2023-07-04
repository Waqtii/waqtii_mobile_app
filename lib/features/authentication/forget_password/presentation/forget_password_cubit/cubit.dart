// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/features/authentication/forget_password/models/forget_password_model.dart';
import 'package:waqtii/features/authentication/forget_password/presentation/forget_password_cubit/states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  ForgetPasswordModel? forgetPasswordModel;

  void resetPassword({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());

    ApiService.postData(url: 'password_reset/', data: {
      'email': email,
    }).then((value) {
      forgetPasswordModel = ForgetPasswordModel.fromJson(value?.data);

      emit(ForgetPasswordSuccessState(forgetPasswordModel!));
    }).catchError((error) {
      print(error);
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }
}
