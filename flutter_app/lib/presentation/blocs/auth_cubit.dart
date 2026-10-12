import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository) : super(const AuthState(loading: true)) {
    _subscription = repository.changes.listen(
      (user) => emit(AuthState(user: user)),
      onError: (_) => emit(const AuthState(error: 'authError')),
    );
  }
  final AuthRepository repository;
  late final StreamSubscription<Object?> _subscription;
  Future<void> login(String email, String password) =>
      _run(() => repository.login(email, password));
  Future<void> signup(String name, String email, String password) =>
      _run(() => repository.signup(name, email, password));
  Future<void> logout() => _run(repository.logout);
  Future<void> _run(Future<void> Function() action) async {
    if (state.loading) return;
    emit(AuthState(user: state.user, loading: true));
    try {
      await action();
      if (!isClosed) emit(AuthState(user: state.user));
    } on FirebaseAuthException catch (error) {
      if (!isClosed) emit(AuthState(user: state.user, error: error.code));
    } catch (_) {
      if (!isClosed) emit(AuthState(user: state.user, error: 'networkError'));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
