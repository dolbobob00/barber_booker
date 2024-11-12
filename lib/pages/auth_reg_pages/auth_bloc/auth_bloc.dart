import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    emit(AuthLoading());
    try {
      UserCredential? user;
      try {
        user = await _authService.signInWithGoogle();
      } catch (e) {
        print('Error during Google Sign-In: $e');
        emit(AuthError(error: 'Google Sign-In failed.'));
        return; // Возвращаем, чтобы завершить выполнение при ошибке
      }

      if (user == null) {
        emit(AuthError(error: 'Sign-In not completed.'));
      } else {
        emit(AuthLoginState(
          user: user.user,
          status: 'user',
        ));
      }
    } catch (e) {
      print('Unexpected error: $e');
      emit(AuthError(error: 'Unexpected error occurred: ${e.toString()}'));
    }
  }

  _signUpByCode(SignUpByCodeEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    try {
      final user = await _authService.loginByCode(event.specialUid);
      if (user != null) {
        emit(
          AuthLoginState(user: user.user, status: 'barber'),
        );
      } else {
        emit(
          AuthError(
            error: 'Error occured, check code.',
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        AuthError(
          error: e.toString(),
        ),
      );
    }
  }

  _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    try {
      await _authService.logOut();
      emit(
        AuthInitial(),
      );
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
    emit(
      AuthLoading(),
    );
    final user = await _authService.getUser() as User?;
    if (user != null) {
      final status = await _authService.getUserStatus(
        user.uid,
      );
      if (status == 'barber') {
        final timeOfWork = await FirebaseFirestore.instance
            .collection('Barbers')
            .doc(user.uid)
            .collection('INFORMATION')
            .doc('CONTACTINFO')
            .get();
        emit(
          AuthLoginState(
            user: user,
            dayTime: {
              'workHourStartTime': timeOfWork['workHourStartTime'],
              'workHourEndTime': timeOfWork['workHourEndTime'],
            },
            status: status,
          ),
        );
      } else {
        emit(
          AuthLoginState(
            user: user,
            status: status,
          ),
        );
      }
    } else {
      emit(AuthLoginState(user: null, status: 'none'));
    }
  }
}
