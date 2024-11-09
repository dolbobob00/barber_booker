import 'package:barber_booker/features/my_input_field.dart';
import 'package:flutter/material.dart';

class QualificationRow extends StatelessWidget {
  const QualificationRow(
      {super.key,
      this.experience,
      this.courses,
      this.specialization,
      this.experienceTextController,
      this.coursesTextController,
      this.specializationTextController});
  final String? experience;
  final String? courses;
  final String? specialization;
  final TextEditingController? experienceTextController;
  final TextEditingController? coursesTextController;
  final TextEditingController? specializationTextController;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25,
        ),
        color: themeof.colorScheme.primary.withOpacity(
          0.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Qualification and courses',
              ),
            ],
          ),
          MyInputField(
            labelText: experience,
            textEditingController: experienceTextController,
            underTextField: Text(
              'Click to change experience amount',
              style: themeof.textTheme.labelSmall,
            ),
          ),
          SizedBox(
            child: MyInputField(
              labelText: courses,
              suffix: Icon(
                Icons.email,
              ),
              textEditingController: coursesTextController,
              underTextField: Text(
                'Click to change couses',
                style: themeof.textTheme.labelSmall,
              ),
            ),
          ),
          SizedBox(
            child: MyInputField(
              labelText: specialization,
              textEditingController: specializationTextController,
              underTextField: Text(
                'Click to change specialization',
                style: themeof.textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
