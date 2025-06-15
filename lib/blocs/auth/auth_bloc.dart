import 'dart:async';

import 'package:nilean/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthState()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<SignUpRequested>(_onSignUp);
    on<SignInRequested>(_onSignIn);
    on<SignOutRequested>(_onSignOut);
    on<ResetPasswordRequested>(_onResetPassword);
    on<SendVerificationEmailRequested>(_onSendVerificationEmailRequested);
    on<CompleteRegistrationRequested>(completeRegistration);
  }

  Future<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _onSignUp(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.unverified, user: user?.user));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.code,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: 'Signup failed. Please try again.',
      ));
    }
  }

  Future<void> _onSignIn(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user?.user,
      ));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.code,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.resetPassword(event.email);
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: 'Password Reset Email Sent',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signOut();
  }

  Future<void> _onSendVerificationEmailRequested(
    SendVerificationEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.sendVerificationEmail();
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      ));
    }
  }

  Future<void> checkEmailVerified(
    CheckEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    final bool isEmailVerified = await authRepository.isEmailVerified();
    if (isEmailVerified) emit(state.copyWith(status: AuthStatus.verified));
  }

  Future<void> completeRegistration(
    CompleteRegistrationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      print(event.name);
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.completeRegistration(event.name);
      emit(state.copyWith(status: AuthStatus.registrationComplete));
    } catch (e) {
      print('Error completing here: $e');
      emit(state.copyWith(
        status: AuthStatus.registrationIncomplete,
        error: 'Something Went Wrong. Please try again.',
      ));
    }
  }
}
