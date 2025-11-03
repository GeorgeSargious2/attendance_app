import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:attendance_app/shared/components.dart';
import 'package:attendance_app/shared/components/common_widgets/custom_button.dart';
import 'package:attendance_app/shared/components/common_widgets/custom_text_form_field.dart';
import 'package:attendance_app/shared/components/helpers.dart/form_validator.dart';
import 'package:attendance_app/shared/components/helpers.dart/spacing.dart';
import 'package:attendance_app/shared/constants/colors.dart';
import '../login_screen/login_screen.dart';
import 'Register_Cubit/Register_Cubit.dart';
import 'Register_Cubit/Register_States.dart';

class registerScreen extends StatelessWidget {
  registerScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, registerStates>(
        listener: (context, state) {
          if (state is createUserSuccessState) {
            navigateAndFinish(context, loginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Logo(),
                      verticalSpace(10),
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      verticalSpace(10),
                      Text('Register now to became a member',
                          style: Theme.of(context).textTheme.labelLarge),
                      verticalSpace(30),
                      ProfPicker(context),
                      verticalSpace(30),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.person),
                        controller: nameController,
                        hintText: 'user name',
                        keyboardType: TextInputType.name,
                        validator: (value) => validateName(value, context),
                      ),
                      CustomTextFormField(
                        validator: (value) => validateEmail(value, context),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.lock),
                        controller: passwordController,
                        hintText: 'password',
                        obscureText: RegisterCubit.get(context).isPassShow,
                        suffixIcon: IconButton(
                            icon: Icon(RegisterCubit.get(context).passSuffix),
                            onPressed: () {
                              RegisterCubit.get(context).passShow();
                            }),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) =>
                            validateRegisterPassword(value, context),
                      ),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.lock),
                        controller: confirmPasswordController,
                        hintText: 'Confirm password',
                        obscureText:
                            RegisterCubit.get(context).isConfirmPassShow,
                        suffixIcon: IconButton(
                            icon: Icon(
                                RegisterCubit.get(context).confirmPassSuffix),
                            onPressed: () {
                              RegisterCubit.get(context).confirmPassShow();
                            }),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => validateConfirmPassword(
                            passwordController.text, value, context),
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'phone number',
                        prefixIcon: Icon(Icons.phone),
                        validator: (value) => validatePhone(value, context),
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        hintText: 'address',
                        prefixIcon: Icon(Icons.home),
                      ),
                      ConditionalBuilder(
                        condition: state is! registerLoadingState,
                        builder: (context) => CustomButton(
                            label: 'Register',
                            width: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (RegisterCubit.get(context).imageFile !=
                                    null) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                  );
                                } else {
                                  showToast(
                                      text: 'Please select a picture',
                                      state: ToastStates.ERROR);
                                }
                              } else {
                                showToast(
                                  text:
                                      'Please fill the required fields correctly',
                                  state: ToastStates.ERROR,
                                );
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget Logo() {
  return Center(
    child: Image(
      width: 200.w,
      height: 200.h,
      image: AssetImage(
          'assets/WhatsApp_Image_2025-07-12_at_12.41.11_5a2db3da-removebg-preview.png'),
    ),
  );
}

Widget ProfPicker(context) {
  return Row(
    children: [
      horizontalSpace(10),
      CircleAvatar(
        radius: 60.r,
        backgroundColor: ColorsManager.greyOpacity,
        backgroundImage: RegisterCubit.get(context).imageFile == null
            ? null
            : FileImage(
                File(RegisterCubit.get(context).imageFile!.path),
              ),
      ),
      horizontalSpace(20),
      Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorsManager.main,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: IconButton(
              onPressed: () {
                RegisterCubit.get(context).pickImageCamera();
              },
              icon: Icon(
                Icons.camera_alt,
                color: ColorsManager.white,
              ),
            ),
          ),
          verticalSpace(5),
          Container(
            decoration: const BoxDecoration(
              color: ColorsManager.main,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: IconButton(
              onPressed: () {
                RegisterCubit.get(context).pickImageGallery();
              },
              icon: const Icon(
                Icons.photo,
                color: ColorsManager.white,
              ),
            ),
          )
        ],
      )
    ],
  );
}
