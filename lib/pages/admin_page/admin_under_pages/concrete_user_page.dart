import 'package:barber_booker/features/barber_info_row.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/pages/admin_page/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserControllPage extends StatelessWidget {
  const UserControllPage({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminBloc>(context);
    final themeof = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BarberInfoRow(
              stars: 5,
            ),
            Center(
              child: Text(
                uid,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            MyButton(
              func: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Column(
                      children: [
                        MyButton(
                          func: () => bloc.add(AdminChangeRolesEvent(
                            role: 'admin',
                            uid: uid,
                          )),
                          text: 'Make admin',
                        ),
                        MyButton(
                          func: () => bloc.add(AdminChangeRolesEvent(
                            role: 'barber',
                            uid: uid,
                          )),
                          text: 'Make barber',
                        ),
                        MyButton(
                          func: () => bloc.add(
                            AdminChangeRolesEvent(
                              role: 'user',
                              uid: uid,
                            ),
                          ),
                          text: 'Make user',
                        ),
                      ],
                    ),
                  ),
                );
              },
              text: 'change role of user',
            ),
          ],
        ),
      ),
    );
  }
}
