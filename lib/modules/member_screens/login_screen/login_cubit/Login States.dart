abstract class loginStates {}

class LoginInitialState extends loginStates {}

class LoginSuccessState extends loginStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginLoadingState extends loginStates {}

class LoginErrorState extends loginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginPassIconState extends loginStates {}

class guestLoginLoadingState extends loginStates {}
