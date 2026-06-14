import 'package:pizzeria_aic/features/auth/domain/entities/auth_result.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);
  Future<AuthResult> call() async {
    return await repository.signInWithGoogle();
  }
}

