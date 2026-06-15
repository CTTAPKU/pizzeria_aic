import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_event.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: const Color(0xff3C3D37),
              textColor: const Color(0xffECDFCC),
              fontSize: 16.0,
            );
          } else if (state is Authenticated) {
            // Success: close the register screen
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 24, bottom: 24, right: 24),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Реєстрація",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          expands: false,
                          decoration: InputDecoration(
                            labelText: "Ім'я",
                            labelStyle: const TextStyle(color: Color(0xffECDFCC)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                color: Color(0xffECDFCC),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xff3C3D37),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: lastNameController,
                          expands: false,
                          decoration: InputDecoration(
                            labelText: "Прізвище",
                            labelStyle: const TextStyle(color: Color(0xffECDFCC)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                color: Color(0xffECDFCC),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xff3C3D37),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Пошта",
                      labelStyle: const TextStyle(color: Color(0xffECDFCC)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Color(0xffECDFCC),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xff3C3D37),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      counterText: '',
                      prefixText: "+38 ",
                      prefixStyle: const TextStyle(color: Color(0xffECDFCC)),
                      labelText: "Телефон",
                      labelStyle: const TextStyle(color: Color(0xffECDFCC)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Color(0xffECDFCC),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xff3C3D37),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Пароль",
                      labelStyle: const TextStyle(color: Color(0xffECDFCC)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Color(0xffECDFCC),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xff3C3D37),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: state is AuthLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  firstNameController.text.isNotEmpty &&
                                  lastNameController.text.isNotEmpty &&
                                  phoneNumberController.text.isNotEmpty) {
                                context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        phoneNumber: phoneNumberController.text.trim(),
                                      ),
                                    );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Введіть дані у всі поля",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.SNACKBAR,
                                  backgroundColor: const Color(0xff3C3D37),
                                  textColor: const Color(0xffECDFCC),
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: const Text("Створити Акаунт"),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
