import 'package:flutter/material.dart';
import 'package:pizzeria_aic/features/auth/data/datasources/auth_service.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, left: 24, bottom: 24, right: 24),
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
                  Text("ПіцаTime чекає на твоє замовлення",
                      style: TextStyle(fontSize: 17))
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
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AuthService().signIN(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                  },
                  child: const Text("Увійти"),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
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
      ),
    );
  }
}
