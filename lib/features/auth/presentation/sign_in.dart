import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_event.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_state.dart';
import 'package:pizzeria_aic/features/auth/presentation/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                        "Ласкаво просимо,",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "ПіцаTime чекає на твоє замовлення",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
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
                          controller: emailController,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
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
                        )
                      ],
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
                                  passwordController.text.isNotEmpty) {
                                context.read<AuthBloc>().add(
                                      SignInRequested(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      ),
                                    );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Введіть пошту та пароль",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.SNACKBAR,
                                  backgroundColor: const Color(0xff3C3D37),
                                  textColor: const Color(0xffECDFCC),
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: const Text("Увійти"),
                          ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text("Зареєструватися"),
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
