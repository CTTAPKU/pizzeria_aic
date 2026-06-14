import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<void> signUP({
    required String email,
    required String password,
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
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIN({
    required String email,
    required String password,
  }) async {
    try {
      await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return;
    } on FirebaseAuthException catch (e) {
      //   TODO: зробити обробку помилок
    }
  }
}
