import 'package:pizzeria_aic/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;
  DeleteAccountUseCase(this.repository);
  Future<void> call() async {
    return await repository.deleteAccount();
  }
}
