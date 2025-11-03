import 'package:attendance_app/models/user_model.dart';

abstract class layoutStates {}

class layoutInitialState extends layoutStates {}

class bottomNavState extends layoutStates {}

class AppModeChangeState extends layoutStates {}

class getUserDataLoadingState extends layoutStates {}

class getUserDataSuccessState extends layoutStates {
  getUserDataSuccessState(UserModel? userModel);
}

class getUserDataErrorState extends layoutStates {
  final String error;

  getUserDataErrorState(this.error);
}

class logOutSuccessState extends layoutStates {}
