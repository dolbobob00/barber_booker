import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QualificationRow extends StatelessWidget {
  const QualificationRow(
      {super.key,
      this.experience,
      this.courses,
      this.specialization,
      this.experienceTextController,
      this.coursesTextController,
      this.specializationTextController,
      required this.uid,
      required this.isEditable});
  final bool isEditable;
  final String? experience;
  final String uid;
  final String? courses;
  final String? specialization;
  final TextEditingController? experienceTextController;
  final TextEditingController? coursesTextController;
  final TextEditingController? specializationTextController;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final bloc = BlocProvider.of<AdminBloc>(context);
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
          const Row(
            children: [
              Text(
                'Qualification and courses',
              ),
            ],
          ),
          MyInputField(
            labelText: experience,
            textEditingController: experienceTextController,
            underTextField: isEditable
                ? Text(
                    'Click to change experience amount',
                    style: themeof.textTheme.labelSmall,
                  )
                : null,
          ),
          SizedBox(
            child: MyInputField(
              labelText: courses,
              suffix: const Icon(
                Icons.email,
              ),
              textEditingController: coursesTextController,
              underTextField: isEditable
                  ? Text(
                      'Click to change couses',
                      style: themeof.textTheme.labelSmall,
                    )
                  : null,
            ),
          ),
          SizedBox(
            child: MyInputField(
              labelText: specialization,
              textEditingController: specializationTextController,
              underTextField: isEditable
                  ? Text(
                      'Click to change specialization',
                      style: themeof.textTheme.labelSmall,
                    )
                  : null,
            ),
          ),
          isEditable
              ? FloatingActionButton(
                  onPressed: () {
                    bloc.add(AdminChangeQualification(
                      experience: experienceTextController!.text.isEmpty
                          ? experience!
                          : experienceTextController!.text,
                      specialization: specializationTextController!.text.isEmpty
                          ? specialization!
                          : specializationTextController!.text,
                      courses: coursesTextController!.text.isEmpty
                          ? courses!
                          : coursesTextController!.text,
                      uid: uid,
                    ));
                  },
                  heroTag: 'asdasdsa',
                  child: const Icon(
                    Icons.update,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
