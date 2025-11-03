import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance_app/shared/components.dart';
import 'package:attendance_app/shared/networks/local/cacheHelper.dart';
import '../../../member_screens/login_screen/login_cubit/Login States.dart';

class adminLoginCubit extends Cubit<loginStates> {
  adminLoginCubit() : super(LoginInitialState());

  static adminLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot customerDoc =
          await firestore.collection('Admins').doc(value.user!.uid).get();
      if (customerDoc.exists) {
        FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          final token = await FirebaseAuth
              .instance.currentUser!.uid; // Get Firebase ID token
          await cacheHelper.SaveData(
              key: 'adminToken', value: token); // Store the token
          emit(LoginSuccessState(value.user!.uid));
        } else {
          emit(LoginErrorState(
              'Email is not verified. Please check your inbox.'));
          showToast(
              text: 'Email is not verified. Please check your inbox.',
              state: ToastStates.ERROR);
        }
      } else {
        emit(LoginErrorState(
            'You are not authorized to access this application'));
        showToast(
            text: 'You are not authorized to access this application',
            state: ToastStates.ERROR);
      }
    }).catchError((error) {
      print('Error: $error');
      if (error is FirebaseAuthException) {
        String errorMessage = '';
        switch (error.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'invalid-credential':
            errorMessage = 'The email or password you entered is incorrect.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          default:
            errorMessage = 'An error occurred.';
        }
        emit(LoginErrorState(errorMessage));
        showToast(text: errorMessage, state: ToastStates.ERROR);
      } else {
        // Handle other types of errors
        emit(LoginErrorState('An error occurred.'));
        showToast(text: 'An error occurred.', state: ToastStates.ERROR);
      }
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassShow = true;

  void passShow() {
    suffix = isPassShow ? Icons.visibility_off : Icons.visibility;
    isPassShow = !isPassShow;
    emit(LoginPassIconState());
  }
}
