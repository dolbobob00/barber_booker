part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthError extends AuthState {
  AuthError({required this.error});
  String error;
}

final class AuthLoading extends AuthState {}

// ignore: must_be_immutable
class AuthLoginState extends AuthState {
  final User? user;
  String status;
  AuthLoginState({required this.user, required this.status});

  AuthLoginState copyWith({User? user, String? status}) {
    return AuthLoginState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
