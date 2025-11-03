import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/shared/components/helpers.dart/shared_pref_helper.dart';
import 'package:attendance_app/shared/networks/local/cacheHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_layout_states.dart';

class AdminLayoutCubit extends Cubit<AdminLayoutStates> {
  AdminLayoutCubit() : super(layoutInitialState());

  static AdminLayoutCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> customerScreens = [];

  void ChangeIndex(int index) {
    currentindex = index;
    emit(bottomNavState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppModeChangeState());
    } else {
      isDark = !isDark;
      cacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppModeChangeState());
      });
    }
  }

  UserModel? userModel;

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    currentindex = 0;
    userModel = null;
    await cacheHelper.RemoveData(key: 'adminToken');
    await SharedPrefHelper.clearAllData();
    await SharedPrefHelper.clearAllSecuredData();
    emit(logOutSuccessState());
  }

  Future<bool> showLogoutConfirmationDialog(
      BuildContext context, title, content, button) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(button),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
