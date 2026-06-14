import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateChangesUseCase {
  final AuthRepository repository;
  GetAuthStateChangesUseCase(this.repository);
  Stream<User?> call()  {
    return  repository.authStateChanges;
  }
}

