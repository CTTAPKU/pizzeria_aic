import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserProfileUseCase {
  final AuthRepository repository;
  UpdateUserProfileUseCase(this.repository);
  Future<void> call({required User user}) async {
    return await repository.updateUserProfile(user);
  }
}

