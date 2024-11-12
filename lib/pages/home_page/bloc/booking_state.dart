part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class BookingBarbersOfSpecialCategory extends BookingState {
  List<Map<String, dynamic>> filteredBarbers;
  BookingBarbersOfSpecialCategory({required this.filteredBarbers});
}

class BookingLoadingState extends BookingState {}

class BookingFetchError extends BookingState {
  String error;
  BookingFetchError({required this.error});
}

class BookingFetchTimeEvent extends BookingState {
  final int start;
  final int end;
  BookingFetchTimeEvent({required this.start, required this.end});
}
