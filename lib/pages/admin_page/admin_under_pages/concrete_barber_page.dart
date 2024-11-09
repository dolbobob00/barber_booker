import 'package:barber_booker/features/barber_info_row.dart';
import 'package:barber_booker/features/barber_services.dart';
import 'package:barber_booker/features/contact_info.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/features/qualification_row.dart';
import 'package:barber_booker/features/stars.dart';
import 'package:barber_booker/features/work_time.dart';
import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:barber_booker/pages/barber_page/bloc/barber_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarberControllPage extends StatelessWidget {
  BarberControllPage({super.key, required this.uid});
  final String uid;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController integration1Controller = TextEditingController();
  final TextEditingController integration2Controller = TextEditingController();
  final TextEditingController coursesTextController = TextEditingController();
  final TextEditingController specializationTextController =
      TextEditingController();
  final TextEditingController experienceTextController =
      TextEditingController();
  final TextEditingController barberTextController = TextEditingController();

  List<dynamic>? workDays = [];
  String? initialTime;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminBloc>(context);
    final blocBarber = BlocProvider.of<BarberInfoBloc>(context)
      ..add(
        BarberFetchData(
          uid: uid,
        ),
      );
    final themeof = Theme.of(context);
    return Scaffold(
      backgroundColor: themeof.colorScheme.primary.withOpacity(
        0.3,
      ),
      body: BlocBuilder<BarberInfoBloc, BarberInfoState>(
        bloc: blocBarber,
        builder: (context, state) {
          if (state is BarberAllInfoState) {
            final List<BarberGlobalService> services =
                state.globalServices?.map(
                      (element) {
                        return BarberGlobalService(
                          serviceName: element,
                          uid: uid,
                        );
                      },
                    ).toList() ??
                    [];

            workDays = state.workDays;
            initialTime = state.workInitialTime;
            endTime = state.workEndTime;
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
                    child: BarberInfoRow(
                      stars: star,
                      name: state.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ContactInfo(
                      phone: state.phone ?? 'Null',
                      email: state.email ?? 'Null',
                      integration1: state.integration1 ?? 'Null',
                      integration2: state.integration2 ?? 'Null',
                      integration1Controller: integration1Controller,
                      integration2Controller: integration2Controller,
                      mailController: mailController,
                      uid: uid,
                      phoneController: phoneController,
                      key: UniqueKey(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QualificationRow(
                      coursesTextController: coursesTextController,
                      experienceTextController: experienceTextController,
                      specializationTextController:
                          specializationTextController,
                      courses: state.courses,
                      experience: state.experience,
                      specialization: state.specialization,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WorkTime(
                      uid: uid,
                      initialTime: initialTime,
                      endTime: endTime,
                      workingDays: workDays ??
                          [
                            'Not',
                            "selected",
                          ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarberServices(
                      barberTextController: barberTextController,
                      services: services,
                      uid: uid,
                      textServices: state.globalServices,
                    ),
                  ),
                  Center(
                    child: Text(
                      uid,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  MyButton(
                    func: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Column(
                            children: [
                              MyButton(
                                func: () => bloc.add(AdminChangeRolesEvent(
                                  role: 'admin',
                                  uid: uid,
                                )),
                                text: 'Make admin',
                              ),
                              MyButton(
                                func: () => bloc.add(AdminChangeRolesEvent(
                                  role: 'barber',
                                  uid: uid,
                                )),
                                text: 'Make barber',
                              ),
                              MyButton(
                                func: () => bloc.add(
                                  AdminChangeRolesEvent(
                                    role: 'user',
                                    uid: uid,
                                  ),
                                ),
                                text: 'Make user',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    text: 'change role of user',
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
