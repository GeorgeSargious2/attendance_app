import 'package:attendance_app/models/user_model.dart';

abstract class AdminLayoutStates {}

class layoutInitialState extends AdminLayoutStates {}

class bottomNavState extends AdminLayoutStates {}

class AppModeChangeState extends AdminLayoutStates {}

class getUserDataLoadingState extends AdminLayoutStates {}

class getUserDataSuccessState extends AdminLayoutStates {
  getUserDataSuccessState(UserModel? userModel);
}

class getUserDataErrorState extends AdminLayoutStates {
  final String error;

  getUserDataErrorState(this.error);
}

class logOutSuccessState extends AdminLayoutStates {}
