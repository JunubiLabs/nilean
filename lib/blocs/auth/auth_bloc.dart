import 'dart:async';

import 'package:buai/models/user_model.dart';
import 'package:buai/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late StreamSubscription<UserModel?> userSubscription;

  AuthBloc(this.authRepository) : super(AuthState()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<SignUpRequested>(_onSignUp);
    on<SignInRequested>(_onSignIn);
    on<SignOutRequested>(_onSignOut);
    on<SendVerificationEmailRequested>(_onSendVerificationEmailRequested);

    userSubscription = authRepository.authStateChanges.asyncMap((user) async {
      if (user == null) return null;
      return await authRepository.getCurrentUser();
    }).listen((user) {
      add(AuthStateChanged(user));
    });
  }

  Future<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    } else {
      final user = await authRepository.getCurrentUser();
      if (user == null || !user.registrationComplete) {
        emit(state.copyWith(
          status: AuthStatus.registrationIncomplete,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      }
    }
  }

  Future<void> _onSignUp(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.unverified));
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
      await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.authenticated));
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
    await authRepository.sendVerificationEmail();
  }

  Future<void> checkEmailVerified(
    CheckEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    final bool isEmailVerified = await authRepository.isEmailVerified();
    if (isEmailVerified) {
      emit(state.copyWith(status: AuthStatus.verified));
    }
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
