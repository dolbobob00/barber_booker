import 'package:barber_booker/pages/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    );
  }
}
