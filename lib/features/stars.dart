import 'package:flutter/material.dart';

class RaitingStars extends StatelessWidget {
  const RaitingStars({super.key, required this.amount});
  final int amount;

  @override
  Widget build(BuildContext context) {
    // Убедимся, что количество звезд не превышает 5
    int filledStars = amount.clamp(0, 5); // Ограничиваем от 0 до 5
    int emptyStars = 5 - filledStars;

    return Row(
      children: [
        // Добавляем заполненные звезды
        for (int i = 0; i < filledStars; i++)
          const Icon(Icons.star, color: Colors.amber),
        // Добавляем незаполненные звезды
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_border, color: Colors.amber),
      ],
    );
  }
}
