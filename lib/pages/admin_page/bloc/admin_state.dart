part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoadingState extends AdminState {}

class AdminDataState extends AdminState {
  List<Map<String, Object>>? basicUsers;
  List<Map<String, Object>>? barberUsers;
  List<Map<String, Object>>? adminUsers;
  AdminDataState({this.adminUsers, this.barberUsers, this.basicUsers});
}
