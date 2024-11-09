import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
    required this.email,
    required this.integration1,
    required this.integration2,
    required this.phone,
    required this.uid,
    required this.integration1Controller,
    required this.integration2Controller,
    required this.mailController,
    required this.phoneController,
  });
  final String uid;
  final String phone;
  final String email;
  final String integration1;
  final String integration2;
  final TextEditingController phoneController;
  final TextEditingController mailController;
  final TextEditingController integration1Controller;
  final TextEditingController integration2Controller;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final bloc = BlocProvider.of<AdminBloc>(context);
    return BlocBuilder<AdminBloc, AdminState>(
      bloc: bloc,
      builder: (context, state) {
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
                    'Contact info',
                  ),
                ],
              ),
              MyInputField(
                textEditingController: phoneController,
                labelText: phone,
                suffix: Icon(
                  Icons.phone,
                ),
                underTextField: Text(
                  'Click to change contact phone',
                  style: themeof.textTheme.labelSmall,
                ),
              ),
              SizedBox(
                child: MyInputField(
                  labelText: email,
                  suffix: Icon(
                    Icons.email,
                  ),
                  textEditingController: mailController,
                  underTextField: Text(
                    'Click to change email',
                    style: themeof.textTheme.labelSmall,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 16,
                    child: MyInputField(
                      labelText: integration1,
                      textEditingController: integration1Controller,
                      underTextField: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                          ),
                          Text(
                            'instagram',
                            style: themeof.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 16,
                    child: MyInputField(
                      labelText: integration2,
                      textEditingController: integration2Controller,
                      underTextField: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.telegram,
                          ),
                          Text(
                            'telegram',
                            style: themeof.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      bloc.add(
                        AdminChangeContactInfoBarberEvent(
                          email: mailController.text.isEmpty
                              ? email
                              : mailController.text,
                          uid: uid,
                          integration1: integration1Controller.text.isEmpty
                              ? integration1
                              : integration1Controller.text,
                          integration2: integration2Controller.text.isEmpty
                              ? integration2
                              : integration2Controller.text,
                          phone: phoneController.text.isEmpty
                              ? phone
                              : phoneController.text,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
