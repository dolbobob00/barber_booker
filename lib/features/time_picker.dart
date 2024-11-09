import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkTimePicker extends StatefulWidget {
  const WorkTimePicker({
    super.key,
    required this.endTime,
    required this.uid,
    required this.initialTime,
  });
  final String uid;
  final String? initialTime;
  final String? endTime;
  @override
  State<WorkTimePicker> createState() => _WorkTimePickerState();
}

class _WorkTimePickerState extends State<WorkTimePicker> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Метод для открытия выбора времени

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    Future<void> pickWorkHours() async {
      final start = await showTimePicker(
        context: context,
        initialTime: startTime ?? const TimeOfDay(hour: 8, minute: 0),
      );

      if (start != null) {
        if (!mounted) return;
        final end = await showTimePicker(
          // ignore: use_build_context_synchronously
          context: context,
          initialTime: endTime ?? const TimeOfDay(hour: 19, minute: 0),
        );
        if (!mounted) return;
        if (end != null) {
          setState(
            () {
              startTime = start;
              endTime = end;
              final adminBloc = BlocProvider.of<AdminBloc>(context);
              adminBloc.add(
                AdminUpdateWorkTimeEvent(
                  workStarts: "${startTime?.format(context) ?? '1233'} ",
                  uid: widget.uid,
                  workEnds: "${endTime?.format(context) ?? '1233'} ",
                ),
              );
            },
          );
        }
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: pickWorkHours,
          child: Text(
            '${startTime?.format(context) ?? "${widget.initialTime}"} - ${endTime?.format(context) ?? "${widget.endTime}"}',
            style: themeof.textTheme.bodyMedium,
          ),
        ),
        Text(
          'Click on time for changing work-hours',
          style: themeof.textTheme.bodySmall,
        ),
      ],
    );
  }
}
