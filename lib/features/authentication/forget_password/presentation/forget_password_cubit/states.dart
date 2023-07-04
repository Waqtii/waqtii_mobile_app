import 'package:waqtii/features/authentication/forget_password/models/forget_password_model.dart';

abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final ForgetPasswordModel forgetPasswordModel;
  ForgetPasswordSuccessState(this.forgetPasswordModel);
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String error;
  ForgetPasswordErrorState(this.error);
}
