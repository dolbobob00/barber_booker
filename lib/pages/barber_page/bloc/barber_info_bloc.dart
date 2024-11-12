import 'package:barber_booker/repository/barber_fetch.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'barber_info_event.dart';
part 'barber_info_state.dart';

class BarberInfoBloc extends Bloc<BarberInfoEvent, BarberInfoState> {
  final BarberFetch _barberFetch = BarberFetch();

  BarberInfoBloc() : super(BarberInfoState()) {
    on<BarberFetchData>(_contactInfoFetch);
  }

  _contactInfoFetch(
      BarberFetchData event, Emitter<BarberInfoState> emit) async {
    try {
      final contactInfoMap = await _barberFetch.fetchBarberContactInfo(
            event.uid,
          ) ??
          {};

      try {
        final topRowInfoMap =
            await _barberFetch.fetchTopRowInfo(event.uid) ?? {};
        try {
          final specializationInfoMap =
              await _barberFetch.fetchExperienceInfo(event.uid) ?? {};
          try {
            final services = await _barberFetch.fetchGlobalServices(
                  event.uid,
                ) ??
                {};
            emit(
              BarberAllInfoState(
                email: contactInfoMap['email'],
                phone: contactInfoMap['phone'],
                integration1: contactInfoMap['integration1'],
                integration2: contactInfoMap['integration2'],
                name: topRowInfoMap['name'],
                stars: topRowInfoMap['stars'],
                courses: specializationInfoMap['courses'],
                experience: specializationInfoMap['experience'],
                specialization: specializationInfoMap['specialization'],
                workDays: contactInfoMap['workDays'],
                workInitialTime: contactInfoMap['initialTime'],
                workEndTime: contactInfoMap['endTime'],
                globalServices: services['GlobalServices'],
                startTime: contactInfoMap['workHourStartTime'],
                endTime: contactInfoMap['workHourEndTime'],
              ),
            );
          } catch (e) {
            emit(
              BarberAllInfoState(
                email: contactInfoMap['email'],
                phone: contactInfoMap['phone'],
                integration1: contactInfoMap['integration1'],
                integration2: contactInfoMap['integration2'],
                name: topRowInfoMap['name'],
                stars: topRowInfoMap['stars'],
                courses: specializationInfoMap['courses'],
                experience: specializationInfoMap['experience'],
                specialization: specializationInfoMap['specialization'],
                workDays: contactInfoMap['workDays'],
                workInitialTime: contactInfoMap['initialTime'],
                workEndTime: contactInfoMap['endTime'],
                startTime: contactInfoMap['workHourStartTime'],
                endTime: contactInfoMap['workHourEndTime'],
              ),
            );
          }
        } catch (e) {
          emit(
            BarberAllInfoState(
              email: contactInfoMap['email'],
              phone: contactInfoMap['phone'],
              integration1: contactInfoMap['integration1'],
              integration2: contactInfoMap['integration2'],
              name: topRowInfoMap['name'],
              stars: topRowInfoMap['stars'],
              workDays: contactInfoMap['workDays'],
              workInitialTime: contactInfoMap['initialTime'],
              workEndTime: contactInfoMap['endTime'],
              startTime: contactInfoMap['workHourStartTime'],
              endTime: contactInfoMap['workHourEndTime'],
            ),
          );
        }
      } catch (e) {
        emit(
          BarberAllInfoState(
            email: contactInfoMap['email'],
            phone: contactInfoMap['phone'],
            integration1: contactInfoMap['integration1'],
            integration2: contactInfoMap['integration2'],
            workDays: contactInfoMap['workDays'],
            workInitialTime: contactInfoMap['initialTime'],
            workEndTime: contactInfoMap['endTime'],
            startTime: contactInfoMap['workHourStartTime'],
            endTime: contactInfoMap['workHourEndTime'],
          ),
        );
      }
    } on Exception catch (e) {
      print(
        e.toString(),
      );
      emit(
        BarberErrorState(
          error: e.toString(),
        ),
      );
    }
  }
}
