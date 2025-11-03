import 'package:attendance_app/modules/member_screens/splash_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:attendance_app/shared/components.dart';
import 'package:attendance_app/shared/components/common_widgets/custom_button.dart';
import 'package:attendance_app/shared/components/common_widgets/custom_text_form_field.dart';
import 'package:attendance_app/shared/components/helpers.dart/form_validator.dart';
import 'package:attendance_app/shared/components/helpers.dart/spacing.dart';
import 'package:attendance_app/shared/constants/colors.dart';
import '../../admin_screens/admin_login_screen/admin_login_screen.dart';
import '../register_screen/register_screen.dart';
import 'forgotten_password_screen.dart';
import 'login_cubit/Login Cubit.dart';
import 'login_cubit/Login States.dart';

class loginScreen extends StatelessWidget {
  loginScreen({super.key});

  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool dot = true;
  final bool isPassShow = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit(),
      child: BlocConsumer<loginCubit, loginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            navigateAndFinish(context, SplashScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      navigateTo(context, AdminLoginScreen());
                    },
                  ),
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Logo(),
                        verticalSpace(30),
                        Text(
                          'Sign in',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        verticalSpace(30),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.email),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                            prefixIcon: const Icon(Icons.lock),
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: loginCubit.get(context).isPassShow,
                            suffixIcon: IconButton(
                                icon: Icon(loginCubit.get(context).suffix),
                                onPressed: () {
                                  loginCubit.get(context).passShow();
                                }),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) =>
                                validateLoginPassword(value, context)),
                        verticalSpace(16),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => CustomButton(
                              width: double.infinity,
                              label: 'Login',
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  loginCubit.get(context).userLogin(
                                        email: emailController.text.trim(),
                                        password: passwordController.text,
                                      );
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        verticalSpace(10),
                        CreateAcc(context),
                        ForgotPass(context),
                      ],
                    ),
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
      image: const AssetImage(
          'assets/WhatsApp_Image_2025-07-12_at_12.41.11_5a2db3da-removebg-preview.png'),
    ),
  );
}

Widget CreateAcc(context) {
  return Align(
    alignment: Alignment.center,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorsManager.textLight),
        children: [
          const TextSpan(text: 'Don\'t have an account?'),
          TextSpan(
            text: 'Create one',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.second,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigateTo(context, registerScreen());
              },
          ),
        ],
      ),
    ),
  );
}

Widget ForgotPass(context) {
  return Align(
    alignment: Alignment.center,
    child: TextButton(
      onPressed: () {
        navigateTo(context, forgottenPasswordScreen());
      },
      child: Text(
        'Forgot password',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorsManager.second,
            ),
      ),
    ),
  );
}
