import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'time_picker.dart';
import 'work_day_widget.dart';

class WorkTime extends StatefulWidget {
  final List<dynamic> workingDays;
  final String uid;
  final String? initialTime;
  final String? endTime;
  final bool isEditable;
  const WorkTime(
      {super.key,
      required this.uid,
      required this.workingDays,
      required this.isEditable,
      this.endTime,
      this.initialTime});

  @override
  State<WorkTime> createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {
  late List<dynamic> workingDays;

  @override
  void initState() {
    super.initState();
    workingDays = List<String>.from(widget.workingDays);
  }

  void toggleWorkingDay(String day) {
    setState(() {
      if (workingDays.contains(day)) {
        workingDays.remove(day);
      } else {
        workingDays.add(day);
      }
    });
  }

  void sendWorkingDaysToBloc() {
    final bloc = BlocProvider.of<AdminBloc>(context);
    bloc.add(
      AdminUpdateWorkDaysEvent(
        workDays: workingDays,
        uid: widget.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    final themeof = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: themeof.colorScheme.primary.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Рабочее расписание',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          WorkTimePicker(
            isEditable: widget.isEditable,
            uid: widget.uid,
            initialTime: widget.initialTime,
            endTime: widget.endTime,
          ),
          const Divider(),
          Text(
            'Дни работы и выходные',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4.0),
          Row(
            children: daysOfWeek.map(
              (day) {
                final isWorkingDay = workingDays.contains(day);
                return WorkDayWidget(
                  day: day,
                  isWorkingDay: isWorkingDay,
                  onDayTapped: widget.isEditable ? toggleWorkingDay : (_) {},
                );
              },
            ).toList(),
          ),
          const Divider(),
          Text(
            'Занятость',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4.0),
          Text(
            'Ближайшие доступные записи по времени',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: themeof.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          widget.isEditable
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: '${UniqueKey().toString().substring(2, 7)}14x',
                    onPressed: sendWorkingDaysToBloc,
                    child: const Icon(Icons.track_changes),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
