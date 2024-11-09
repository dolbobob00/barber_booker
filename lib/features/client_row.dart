import 'package:barber_booker/features/my_list_tile.dart';
import 'package:flutter/material.dart';

class ClientRow extends StatelessWidget {
  const ClientRow({super.key, this.titleText, this.subtitleText, this.onTap});
  final Widget? titleText;
  final Widget? subtitleText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: MyListTile(
            subtitleText: subtitleText,
            titleText: titleText,
            rightSection: Container(),
          ),
        ),
      ],
    );
  }
}
