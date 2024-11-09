import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key, required this.list, required this.func});
  final List<String> list;
  final Function(String) func;
  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String dropdownValue = widget.list.first;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return DropdownButton(
      dropdownColor: themeof.colorScheme.primary,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: themeof.textTheme.bodySmall!.copyWith(
        color: themeof.colorScheme.secondary,
      ),
      underline: Container(
        height: 2,
        color: themeof.colorScheme.secondary,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.func(dropdownValue);
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
