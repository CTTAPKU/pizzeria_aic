import 'package:pizzeria_aic/features/auth/domain/entities/auth_result.dart';
import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<AuthResult> signInWithGoogle();

  Future<User> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  Future<User> signInWithEmail({
    required String email,
    required String password,
  });

  Future<String?> getIdToken();

  Future<User?> getCurrentUser();

  Future<void> signOut();

  Future<void> updateUserProfile(User user);

  Future<void> deleteAccount();

  Stream<User?> get authStateChanges;
}
