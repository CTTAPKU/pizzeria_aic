import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;
  GetCurrentUserUseCase(this.repository);
  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
