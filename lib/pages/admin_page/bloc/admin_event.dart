part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class AdminGetUsersEvent extends AdminEvent {}

class AdminCreateBarberEvent extends AdminEvent {}

class AdminUpdateWorkDaysEvent extends AdminEvent {
  final List<dynamic> workDays;
  final String uid;
  AdminUpdateWorkDaysEvent({
    required this.workDays,
    required this.uid,
  });
}

class AdminUpdateWorkTimeEvent extends AdminEvent {
  final String workStarts;
  final String workEnds;
  final String uid;
  AdminUpdateWorkTimeEvent({
    required this.workStarts,
    required this.uid,
    required this.workEnds,
  });
}

class AdminDeleteGlobalService extends AdminEvent {
  final String name;
  final String uid;

  AdminDeleteGlobalService({
    required this.name,
    required this.uid,
  });
}

class AdminUpdateGlobalServiceEvent extends AdminEvent {
  final String name;
  final String uid;

  AdminUpdateGlobalServiceEvent({
    required this.name,
    required this.uid,
  });
}

class AdminChangeContactInfoBarberEvent extends AdminEvent {
  final String phone;
  final String email;
  final String integration1;
  final String integration2;
  final String uid;

  AdminChangeContactInfoBarberEvent(
      {required this.phone,
      required this.email,
      required this.uid,
      required this.integration1,
      required this.integration2});
}

class AdminChangeRolesEvent extends AdminEvent {
  AdminChangeRolesEvent({required this.role, required this.uid});
  final String role;
  final String uid;
}
