import 'package:flutter/material.dart';

class WorkDayWidget extends StatefulWidget {
  final bool isWorkingDay;
  final String day;
  final ValueChanged<String> onDayTapped;

  const WorkDayWidget({
    super.key,
    required this.day,
    required this.isWorkingDay,
    required this.onDayTapped,
  });

  @override
  State<WorkDayWidget> createState() => _WorkDayWidgetState();
}

class _WorkDayWidgetState extends State<WorkDayWidget> {
  late bool isWorkingday = widget.isWorkingDay;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isWorkingday = !isWorkingday;
        });
        widget.onDayTapped(widget.day);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isWorkingday ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          widget.day,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
