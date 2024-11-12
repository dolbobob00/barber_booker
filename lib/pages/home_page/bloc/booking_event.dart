part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class FetchBarbersEvent implements BookingEvent {
  final String categoryName;
  FetchBarbersEvent({required this.categoryName});
}
class FetchBarberTimeEvent implements BookingEvent {
  final String uid;
  FetchBarberTimeEvent({required this.uid});
}
