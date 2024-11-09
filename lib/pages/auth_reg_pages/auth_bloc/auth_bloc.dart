import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../repository/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = FirebaseAuthService();

  AuthBloc() : super(AuthInitial()) {
    on<CheckLogedInEvent>(_checkLogedIn);
    on<LogInEvent>(_logIn);
    on<RegisterEvent>(_register);
    on<SignOutEvent>(_signOut);
    on<SignUpByCodeEvent>(_signUpByCode);
    on<SignUpByGoogleEvent>(_signUpByGoogle);
  }
  _signUpByGoogle(SignUpByGoogleEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user == null) {
        emit(
          AuthError(error: 'Not compleeted'),
        );
      } else {
        emit(
          AuthLoginState(
            user: user.user,
            status: 'user',
          ),
        );
      }
    } catch (e) {
      AuthError(
        error: e.toString(),
      );
    }
  }

  _signUpByCode(SignUpByCodeEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _authService.loginByCode(event.specialUid);
      if (user != null) {
        emit(
          AuthLoginState(user: user.user, status: 'barber'),
        );
      }
    } catch (e) {
      AuthError(
        error: e.toString(),
      );
    }
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
      print('create user with basic status');
      final user =
          await _authService.registerUser(event.loginEmail, event.password);
      emit(
        AuthLoginState(
          user: user.user,
          status: 'user',
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

  _logIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    try {
      print('login checking user');
      final user = await _authService.loginWithEmail(
        event.loginEmail,
        event.password,
      ) as UserCredential?;

      if (user != null) {
        print('check status in bloc');
        final status = await _authService.getUserStatus(
          user.user!.uid,
        );
        emit(
          AuthLoginState(
            user: user.user,
            status: status,
          ),
        );
      }
    } catch (e) {
      emit(
        AuthError(
          error: e.toString(),
        ),
      );
    }
  }

  _checkLogedIn(CheckLogedInEvent event, Emitter<AuthState> emit) async {
    final user = await _authService.getUser() as User?;
    if (user != null) {
      final status = await _authService.getUserStatus(
        user.uid,
      );
      emit(
        AuthLoginState(
          user: user,
          status: status,
        ),
      );
    } else {
      emit(AuthLoginState(user: null, status: 'none'));
    }
  }
}
