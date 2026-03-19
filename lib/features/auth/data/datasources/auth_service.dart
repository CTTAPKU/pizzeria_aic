import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzeria_aic/core/widgets/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<void> signUP({
    required String email,
    required String password,
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);

      CollectionReference users = firestoreInstance.collection("Users");
      final uid = authInstance.currentUser!.uid;
      users.add({
        'firstName': firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "uid": uid
      });
    } on FirebaseAuthException catch (e) {
      String message = 'Помилка';
      if (e.code == 'weak-password') message = "Ненадійний пароль";
      if (e.code == 'email-already-in-use')
        message = "Обліковий запис вже існує";
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff3C3D37),
        textColor: const Color(0xffECDFCC),
        fontSize: 16.0,
      );
    }
  }

  Future<void> signIN(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException {
      Fluttertoast.showToast(
        msg: "Неправильні облікові дані",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff3C3D37),
        textColor: const Color(0xffECDFCC),
        fontSize: 16.0,
      );
    }
  }
}
