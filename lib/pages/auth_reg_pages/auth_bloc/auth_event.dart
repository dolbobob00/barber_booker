part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckLogedInEvent implements AuthEvent {}

class SignUpAsAdminEvent implements AuthEvent {}

class SignUpAsGuestEvent implements AuthEvent {}

class SignOutEvent implements AuthEvent {}

class SignUpByCodeEvent implements AuthEvent {
  final String specialUid;
  SignUpByCodeEvent({required this.specialUid});
}

class SignUpByGoogleEvent implements AuthEvent {
  SignUpByGoogleEvent();
}

class RegisterEvent implements AuthEvent {
  String password;
  String loginEmail;

  RegisterEvent({
    required this.loginEmail,
    required this.password,
  });
}

class LogInEvent implements AuthEvent {
  String password;
  String loginEmail;
  LogInEvent({
    required this.loginEmail,
    required this.password,
  });
}

class SignUpEvent implements AuthEvent {}
