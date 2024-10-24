import 'package:flutter/material.dart';

class RegistrationRow extends StatelessWidget {
  const RegistrationRow({super.key, required this.iconButtons});
  final List<MyIconButton> iconButtons;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...iconButtons,
      ],
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.icon, required this.func});
  final Widget? icon;
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon ??
          Icon(
            Icons.alarm,
          ),
      onPressed: func,
    );
  }
}
