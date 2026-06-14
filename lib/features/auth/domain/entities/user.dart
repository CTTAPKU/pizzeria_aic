import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String uid;

  const User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.uid});

  @override
  List<Object?> get props => [email, firstName, lastName, phoneNumber, uid];
}
