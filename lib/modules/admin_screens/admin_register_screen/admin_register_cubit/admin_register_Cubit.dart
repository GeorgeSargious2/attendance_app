import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/shared/components.dart';
import '../../../member_screens/register_screen/Register_Cubit/Register_States.dart';

class adminRegisterCubit extends Cubit<registerStates> {
  adminRegisterCubit() : super(registerInitialState());

  static adminRegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      if (imageFile == null) {
        emit(registerErrorState('Please select a profile image'));
        return;
      }

      emit(registerLoadingState());

      // First create user in Firebase Auth
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Then upload image
      final imageUrl = await uploadProfileImage(email);

      // Finally create user document
      await userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: userCredential.user!.uid,
        image: imageUrl,
        address: address,
      );

      // Send verification email
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      showToast(
          text: 'Email verification has been sent to your email',
          state: ToastStates.SUCCESS);

      emit(createUserSuccessState());
    } on FirebaseAuthException catch (e) {
      String errorMessage = getFirebaseErrorMessage(e);
      emit(registerErrorState(errorMessage));
      print(errorMessage.toString());
      showToast(text: errorMessage, state: ToastStates.ERROR);
    } catch (e) {
      emit(registerErrorState(e.toString()));
      print(e.toString());
      showToast(text: e.toString(), state: ToastStates.ERROR);
    }
  }

  Future<String> uploadProfileImage(String email) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref(
          'admins-images/$email/${Uri.file(imageFile!.path).pathSegments.last}');
      await storageRef.putFile(File(imageFile!.path));
      return await storageRef.getDownloadURL();
    } catch (e) {
      emit(imageUploadErrorState(e.toString()));
      throw e;
    }
  }

  Future<void> userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String image,
    required String address,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      profileImage: image,
      address: address,
      token: '',
      isActive: true,
      totalPoints: 0,
      attendanceRecords: [],
    );
    FirebaseFirestore.instance
        .collection('Admins')
        .doc(uId)
        .set(model.toMap())
        .then((value) {})
        .catchError((error) {
      emit(createUserErrorState(error.toString()));
    });
  }

  String getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return e.message ?? 'Registration failed';
    }
  }

  //Image picker methods
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  void pickImageCamera() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 95,
    );
    imageFile = pickedImage;
    emit(imageCameraPickerState());
  }

  void pickImageGallery() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 95,
    );
    imageFile = pickedImage;
    emit(imageGalleryPickerState());
  }

  //Show password methods
  IconData passSuffix = Icons.visibility;
  bool isPassShow = true;

  void passShow() {
    passSuffix = isPassShow ? Icons.visibility_off : Icons.visibility;
    isPassShow = !isPassShow;
    emit(registerPassIconState());
  }

  IconData confirmPassSuffix = Icons.visibility;
  bool isConfirmPassShow = true;

  void confirmPassShow() {
    confirmPassSuffix =
        isConfirmPassShow ? Icons.visibility_off : Icons.visibility;
    isConfirmPassShow = !isConfirmPassShow;
    emit(registerPassIconState());
  }
}
