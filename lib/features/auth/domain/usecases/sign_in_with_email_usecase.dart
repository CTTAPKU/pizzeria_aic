import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailUseCase {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);
  Future<User> call({
    required String email,
    required String password,
}) async {
    return await repository.signInWithEmail(email: email, password: password);
  }
}
