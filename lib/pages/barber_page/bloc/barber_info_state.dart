part of 'barber_info_bloc.dart';

class BarberInfoState {}

class BarberAllInfoState implements BarberInfoState {
  String? phone;
  String? name;
  String? stars;
  String? experience;
  String? specialization;
  String? courses;
  String? email;
  String? integration1;
  String? integration2;
  List<dynamic>? workDays;
  List<dynamic>? globalServices;
  String? workInitialTime;
  String? workEndTime;

  BarberAllInfoState({
    this.globalServices,
    this.workDays,
    this.integration1,
    this.integration2,
    this.phone,
    this.stars,
    this.email,
    this.name,
    this.courses,
    this.experience,
    this.specialization,
    this.workEndTime,
    this.workInitialTime,
  });

  BarberAllInfoState copyWith({
    String? phone,
    String? stars,
    String? integration1,
    String? integration2,
    String? email,
    String? name,
  }) {
    return BarberAllInfoState(
      stars: stars ?? this.stars,
      integration1: integration1 ?? this.integration1,
      integration2: integration2 ?? this.integration2,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
