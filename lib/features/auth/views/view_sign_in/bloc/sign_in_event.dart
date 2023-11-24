part of 'sign_in_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  String password;
  String email;
  SignUpEvent(this.email, this.password);
}

class SignInEvent extends AuthEvent {
  String password;
  String email;
  SignInEvent(this.email, this.password);
}
