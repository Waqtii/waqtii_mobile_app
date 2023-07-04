abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeIconPassState extends RegisterStates {}

// Register User //
class RegisterUserLoadingState extends RegisterStates {}

class RegisterUserSuccessState extends RegisterStates {}

class RegisterUserErrorState extends RegisterStates {
  final String error;

  RegisterUserErrorState(this.error);
}

// Register Monitor //

class RegisterMonitorLoadingState extends RegisterStates {}

class RegisterMonitorSuccessState extends RegisterStates {}

class RegisterMonitorErrorState extends RegisterStates {
  final String error;

  RegisterMonitorErrorState(this.error);
}

//

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangeGenderState extends RegisterStates {}
