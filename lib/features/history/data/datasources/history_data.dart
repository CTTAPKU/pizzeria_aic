import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryData {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> setHistory(
      String pizzaName, String pizzaId, String orderAmount) async {
    DocumentReference newCityRef =
        FirebaseFirestore.instance.collection("orderHistory").doc();
    newCityRef.set({
      'pizzaName': pizzaName,
      'pizza_id': pizzaId,
      "uid": uid,
      "orderStatus": true,
      "cookingStatus": false,
      "orderAmount": orderAmount,
      "id": newCityRef.id
    });
    return;
  }

  Stream<List<Map<String, dynamic>>> getUserHistory() async* {
    yield* FirebaseFirestore.instance
        .collection('orderHistory')
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> deleteHistory(id) async {
    FirebaseFirestore.instance.collection('orderHistory').doc(id).delete();
    return;
  }
}
