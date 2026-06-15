import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzeria_aic/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth state changes (Firebase User)
  Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  firebase_auth.User? get currentUser => _auth.currentUser;

  Future<firebase_auth.UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<firebase_auth.UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await deleteUserProfile(user.uid);
      await user.delete();
    }
  }

  Future<String?> getIdToken() async {
    return await _auth.currentUser?.getIdToken();
  }

  Future<void> createUserProfile(UserModel userModel) async {
    await _firestore.collection('Users').doc(userModel.uid).set(userModel.toMap());
  }

  Future<void> updateUserProfile(UserModel userModel) async {
    await _firestore.collection('Users').doc(userModel.uid).update(userModel.toMap());
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('Users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return doc.data();
    }
    
    // Fallback search by query, in case the document ID is not the UID
    final querySnapshot = await _firestore
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .get();
        
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    }
    return null;
  }

  Future<void> deleteUserProfile(String uid) async {
    await _firestore.collection('Users').doc(uid).delete();
  }
}
