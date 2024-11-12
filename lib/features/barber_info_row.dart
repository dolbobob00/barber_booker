import 'package:barber_booker/features/stars.dart';
import 'package:flutter/material.dart';

class BarberInfoRow extends StatelessWidget {
  const BarberInfoRow({super.key, this.name, required this.stars});
  final String? name;
  final int stars;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
              top: 10,
              right: 25,
            ),
            child: CircleAvatar(
              radius: 58,
            ),
          ),
          Column(
            children: [
              Text(name ?? 'NAME'),
              RaitingStars(
                amount: stars,
              ),
            ],
          )
        ],
      ),
    );
  }
}
