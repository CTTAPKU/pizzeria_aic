import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';

class AuthResult {
  final User user;
  final bool isNewUser;

  const AuthResult({required this.user, required this.isNewUser});
}
