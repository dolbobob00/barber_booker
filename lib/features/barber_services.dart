import 'package:barber_booker/features/dropdown_button.dart';
import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BarberService extends StatelessWidget {
  const BarberService(
      {super.key,
      required this.cost,
      required this.serviceName,
      required this.stars,
      required this.time});
  final String serviceName;
  final Widget stars;
  final String cost;
  final String time;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          child: Icon(
            Icons.room_service,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25,
              ),
              color: themeof.colorScheme.primary.withOpacity(
                0.4,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: [
                      Text(
                        serviceName,
                      ),
                      stars,
                      Text(
                        cost,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    color: themeof.colorScheme.primary.withOpacity(
                      0.4,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.timelapse,
                      ),
                      Text(
                        "$time min's",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BarberGlobalService extends StatelessWidget {
  const BarberGlobalService({
    super.key,
    required this.serviceName,
    required this.uid,
     this.onDelete,
  });
  final String serviceName;
  final VoidCallback? onDelete;
  final String uid;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25,
              ),
              color: Color.fromARGB(170, 223, 16, 1),
            ),
            child: IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_forever,
                color: themeof.colorScheme.secondary,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25,
              ),
              color: themeof.colorScheme.primary.withOpacity(
                0.4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  serviceName,
                  style: themeof.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarberServices extends StatefulWidget {
  BarberServices({
    super.key,
    required this.services,
    required this.barberTextController,
    required this.uid,
    required this.textServices,
  });
  final TextEditingController barberTextController;
  final List<BarberGlobalService> services;
  final String uid;
  final List<dynamic>? textServices;

  @override
  State<BarberServices> createState() => _BarberServicesState();
}

class _BarberServicesState extends State<BarberServices> {
  String? valueServiceGlobal;

  @override
  Widget build(BuildContext context) {
    void addGlobalService(String value) {
      valueServiceGlobal = value;
    }

    void removeService(String serviceName) {
      setState(() {
        // Удаление услуги из списка services
        widget.services
            .removeWhere((service) => service.serviceName == serviceName);
      });

      // Отправка события для удаления из Firebase
      final bloc = BlocProvider.of<AdminBloc>(context);
      bloc.add(AdminDeleteGlobalService(name: serviceName, uid: widget.uid));
    }

    void addGlobalServiceToBloc(String value) {
      setState(() {

        widget.services.add(
          BarberGlobalService(
            serviceName: value,
            onDelete: () => removeService(value),
            uid: widget.uid,
          ),
        );
        final bloc = BlocProvider.of<AdminBloc>(context);
        bloc.add(
          AdminUpdateGlobalServiceEvent(name: value, uid: widget.uid),
        );
      });
    }

    const List<String> globalServices = [
      'Уход за волосами',
      'Уход за бородой и усами',
      'Уход за кожей лица',
      'Уход за руками',
      'Премиальные и комплексные услуги',
      'Дополнительные услуги для комфорта клиентов'
    ];
    final themeof = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25,
        ),
        color: Theme.of(context).colorScheme.primary.withOpacity(
              0.4,
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
          ),
          Text(
            "Global barber services",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          ...widget.services.map((service) => BarberGlobalService(
                serviceName: service.serviceName,
                uid: widget.uid,
                onDelete: () => removeService(
                    service.serviceName), // Передаём функцию удаления
              )),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 8,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => FittedBox(
                      child: Dialog(
                        backgroundColor: themeof.colorScheme.primary,
                        elevation: 5,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Choose global service',
                                  style: themeof.textTheme.bodyMedium!.copyWith(
                                    color: themeof.colorScheme.secondary,
                                  ),
                                ),
                              ),
                              MyDropdownButton(
                                list: globalServices,
                                func: addGlobalService,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.highlight_remove,
                                      size: 36,
                                      color: themeof.colorScheme.secondary,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addGlobalServiceToBloc(
                                        valueServiceGlobal ?? 'null',
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 36,
                                      color: themeof.colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                heroTag: 'sadsad',
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
