import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/features/qualification_row.dart';
import 'package:barber_booker/pages/barber_page/bloc/barber_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

import '../../domain/constants.dart';
import '../../features/barber_info_row.dart';
import '../../features/barber_services.dart';
import '../../features/contact_info.dart';
import '../../features/work_time.dart';
import '../booking_page/booking_page.dart';

class BarberProfile extends StatefulWidget {
  const BarberProfile({super.key, required this.selfUid, required this.uid});
  final String selfUid;
  final String uid;
  @override
  State<BarberProfile> createState() => _BarberProfileState();
}

class _BarberProfileState extends State<BarberProfile> {
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final barberBloc = BlocProvider.of<BarberInfoBloc>(context)
      ..add(
        BarberFetchData(
          uid: widget.uid,
        ),
      );
    List<dynamic>? workDays = [];
    String? initialTime;
    String? endTime;

    return Scaffold(
      backgroundColor: themeof.colorScheme.primary.withOpacity(
        0.8,
      ),
      appBar: AppBar(),
      body: BlocBuilder<BarberInfoBloc, BarberInfoState>(
        bloc: barberBloc,
        builder: (context, state) {
          if (state is BarberAllInfoState) {
            final List<BarberGlobalService> services =
                state.globalServices?.map(
                      (element) {
                        return BarberGlobalService(
                          serviceName: element,
                          uid: widget.uid,
                        );
                      },
                    ).toList() ??
                    [];

            workDays = state.workDays;
            List<int> existingDays = [];
            for (var day in workDays ?? []) {
              if (day.isNotEmpty && dayToNumber.containsKey(day)) {
                existingDays.add(dayToNumber[day]!);
              }
            }
            List<int> allDays = List.generate(7, (index) => index + 1);

            List<int> missingDays =
                allDays.where((day) => !existingDays.contains(day)).toList();

            initialTime = state.workInitialTime;
            endTime = state.workEndTime;
            int startTime = state.startTime ?? 8;
            int endWorkTime = state.endTime ?? 20;
            int star = 0;
            if (state.stars == "1") {
              star = 1;
            } else if (state.stars == '2') {
              star = 2;
            } else if (state.stars == '3') {
              star = 3;
            } else if (state.stars == '4') {
              star = 4;
            } else if (state.stars == '5') {
              star = 5;
            }
            return SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuroWrapper(
                      color: themeof.colorScheme.primary.withOpacity(0.4),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                      widget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BarberInfoRow(
                          stars: star,
                          name: state.name,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrettyNeumorphicButton(
                      label: 'Click to book a time',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              selfUid: widget.selfUid,
                              uid: widget.uid,
                              startTime: startTime,
                              endTime: endWorkTime,
                              missingDays: missingDays,
                            ),
                          ),
                        );
                      },
                      duration: const Duration(
                        milliseconds: 600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuroWrapper(
                      color: themeof.colorScheme.primary.withOpacity(0.4),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                      widget: WorkTime(
                        isEditable: false,
                        uid: widget.uid,
                        workingDays: workDays ?? [],
                        initialTime: initialTime,
                        endTime: endTime,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuroWrapper(
                      color: themeof.colorScheme.primary.withOpacity(0.4),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                      widget: ContactInfo(
                        email: state.email ?? '',
                        integration1: state.integration1 ?? '',
                        integration2: state.integration2 ?? '',
                        isEditable: false,
                        phone: state.phone ?? '',
                        uid: widget.uid,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuroWrapper(
                      color: themeof.colorScheme.primary.withOpacity(0.4),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                      widget: QualificationRow(
                        uid: widget.uid,
                        isEditable: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeuroWrapper(
                      color: themeof.colorScheme.primary.withOpacity(0.4),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                      widget: BarberServices(
                        isEditable: false,
                        services: services,
                        textServices: state.globalServices,
                        uid: widget.uid,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
