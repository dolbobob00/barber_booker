
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../repository/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = FirebaseAuthService();

  AuthBloc() : super(AuthInitial()) {
    on<CheckLogedInEvent>(_checkLogedIn);
    on<LogInEvent>(_logIn);
    on<SignUpAsAdminEvent>(_signUpAsAdmin);
    on<RegisterEvent>(_register);
    on<SignOutEvent>(_signOut);
  }
  _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authService.logOut();
    } catch (e) {
      emit(
        AuthError(
          error: e.toString(),
        ),
      );
    }
  }

  _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user =
          await _authService.registerUser(event.loginEmail, event.password);
      emit(
        AuthLoginState(
          user: user.user,
        ),
      );
    } catch (e) {
      emit(
        AuthError(
          error: e.toString(),
        ),
      );
    }
  }

  _signUpAsAdmin(SignUpAsAdminEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    try {} catch (e) {
      AuthError(
        error: e.toString(),
      );
    }
  }

  _logIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    final user = await _authService.loginWithEmail(
      event.loginEmail,
      event.password,
    ) as UserCredential?;
    if (user != null) {
      emit(
        AuthLoginState(user: user.user),
      );
    }
  }

  _checkLogedIn(CheckLogedInEvent event, Emitter<AuthState> emit) async {
    final user = await _authService.getUser();
    user == null
        ? emit(AuthLoginState(user: user))
        : emit(AuthLoginState(user: user));
  }
}
