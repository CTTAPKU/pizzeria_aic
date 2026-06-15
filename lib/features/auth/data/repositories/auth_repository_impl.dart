import 'dart:async';
import 'package:pizzeria_aic/features/auth/data/datasources/remote_datasource.dart';
import 'package:pizzeria_aic/features/auth/data/models/user_model.dart';
import 'package:pizzeria_aic/features/auth/domain/entities/auth_result.dart';
import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<User?> get authStateChanges {
    return remoteDataSource.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      final profileMap = await remoteDataSource.getUserProfile(firebaseUser.uid);
      if (profileMap != null) {
        return UserModel.fromMap(profileMap);
      }

      return UserModel(
        email: firebaseUser.email ?? '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        uid: firebaseUser.uid,
      );
    });
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = remoteDataSource.currentUser;
    if (firebaseUser == null) return null;

    final profileMap = await remoteDataSource.getUserProfile(firebaseUser.uid);
    if (profileMap != null) {
      return UserModel.fromMap(profileMap);
    }

    return UserModel(
      email: firebaseUser.email ?? '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      uid: firebaseUser.uid,
    );
  }

  @override
  Future<String?> getIdToken() async {
    return await remoteDataSource.getIdToken();
  }

  @override
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    
    final firebaseUser = credential.user!;
    final profileMap = await remoteDataSource.getUserProfile(firebaseUser.uid);
    
    if (profileMap != null) {
      return UserModel.fromMap(profileMap);
    }

    return UserModel(
      email: firebaseUser.email ?? email,
      firstName: '',
      lastName: '',
      phoneNumber: '',
      uid: firebaseUser.uid,
    );
  }

  @override
  Future<AuthResult> signInWithGoogle() async {
    throw UnimplementedError('Google Sign-In has not been implemented in this app version.');
  }

  @override
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final credential = await remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user!;
    final userModel = UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      uid: firebaseUser.uid,
    );
    await remoteDataSource.createUserProfile(userModel);
    
    return userModel;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<void> updateUserProfile(User user) async {
    final userModel = UserModel(
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      uid: user.uid,
    );
    await remoteDataSource.updateUserProfile(userModel);
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.deleteAccount();
  }
}
