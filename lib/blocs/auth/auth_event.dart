part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateChanged extends AuthEvent {
  final User? user;
  const AuthStateChanged(this.user);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}

class SendVerificationEmailRequested extends AuthEvent {}

class CheckEmailVerificationRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;
  const ResetPasswordRequested(this.email);
}

class CompleteRegistrationRequested extends AuthEvent {
  final String name;
  const CompleteRegistrationRequested(this.name);
}
