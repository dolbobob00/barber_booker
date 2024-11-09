import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarberPage extends StatelessWidget {
  const BarberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        authBloc.add(
          SignOutEvent(),
        );
      }),
      body: const Column(
        children: [
          Center(
            child: Text(
              'AHHHHH BARBER',
            ),
          )
        ],
      ),
    );
  }
}
