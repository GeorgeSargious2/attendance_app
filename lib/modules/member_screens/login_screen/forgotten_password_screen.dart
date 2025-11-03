import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/shared/components.dart';
import 'login_screen.dart';

class forgottenPasswordScreen extends StatelessWidget {
  forgottenPasswordScreen({super.key});

  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password reset'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  'Find Your Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please enter your email to reset your password.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                formField1(
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Email Address must not be empty';
                      }
                    },
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Icons.email),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue,
                      ),
                      width: 200,
                      height: 45,
                      child: TextButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (FirebaseAuth
                                    .instance.currentUser?.emailVerified ??
                                true) {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: emailController.text);
                                showToast(
                                    text:
                                        'Password reset email has been sent to your email address',
                                    state: ToastStates.SUCCESS);
                                navigateAndFinish(context, loginScreen());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showToast(
                                      text: 'No user found for that email.',
                                      state: ToastStates.ERROR);
                                } else if (e.code == 'invalid-email') {
                                  showToast(
                                      text: 'The email address is invalid.',
                                      state: ToastStates.ERROR);
                                } else {
                                  showToast(
                                      text:
                                          'An error occurred. Please try again.',
                                      state: ToastStates.ERROR);
                                }
                              }
                            } else {
                              // Display message to verify email
                              showToast(
                                  text:
                                      'Please verify your email address first.',
                                  state: ToastStates.ERROR);
                            }
                          } else {
                            showToast(
                                text: 'Please enter your email',
                                state: ToastStates.ERROR);
                          }
                        },
                        child: const Text(
                          'Reset password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
