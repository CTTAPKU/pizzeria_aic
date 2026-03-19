import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final usersStore = FirebaseFirestore.instance.collection('Users');

  Future<Map<String, dynamic>> getUserByUId(String uid) async {
    final users = await usersStore.where("uid", isEqualTo: uid).get();
    return users.docs.first.data();
  }
}
