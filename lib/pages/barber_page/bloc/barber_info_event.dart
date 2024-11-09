part of 'barber_info_bloc.dart';

@immutable
sealed class BarberInfoEvent {}

class BarberFetchData implements BarberInfoEvent {
  String uid;
  BarberFetchData({required this.uid});
}

class BarberInfoStarsNameEvent implements BarberInfoEvent {}
