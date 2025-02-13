part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  loading,
  authenticated,
  unauthenticated,
  unverified,
  verified,
  registrationComplete,
  registrationIncomplete
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.error,
  });

  @override
  List<Object?> get props => [status, user, error];

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
