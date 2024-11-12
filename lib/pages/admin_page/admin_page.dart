import 'package:barber_booker/pages/admin_page/admin_under_pages/all_barbers_page.dart';
import 'package:barber_booker/pages/admin_page/admin_under_pages/clients_page.dart';
import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';

import 'bloc/admin_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  final List<Widget> _body = [
    const ClientsPage(),
    const AllBarbersPage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final adminBloc = BlocProvider.of<AdminBloc>(context);
    return Scaffold(
      body: Center(
        child: _body.elementAt(_selectedIndex),
      ),
      backgroundColor: themeof.colorScheme.primary.withOpacity(0.95),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: themeof.colorScheme.primary.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GNav(
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              duration: const Duration(milliseconds: 400),
              backgroundColor: themeof.colorScheme.primary,
              color: themeof.colorScheme.tertiary,
              tabBackgroundColor:
                  themeof.colorScheme.onPrimary.withOpacity(0.5),
              padding: const EdgeInsets.all(16),
              activeColor: themeof.colorScheme.secondary,
              tabs: [
                GButton(
                  icon: Icons.person,
                  text: 'Clients',
                  textStyle: themeof.textTheme.labelSmall,
                ),
                GButton(
                  icon: Icons.support_agent,
                  text: 'Staff',
                  textStyle: themeof.textTheme.labelSmall,
                ),
                GButton(
                  icon: HugeIcons.strokeRoundedService,
                  text: 'Service\'s',
                  textStyle: themeof.textTheme.labelSmall,
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Setting\'s',
                  textStyle: themeof.textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adminBloc.add(
            AdminGetUsersEvent(),
          );
        },
        child: const Icon(
          Icons.update,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Admin page',
        ),
        leading: IconButton(
          onPressed: () {
            authBloc.add(
              SignOutEvent(),
            );
            setState(() {});
          },
          icon: const Icon(
            Icons.exit_to_app,
          ),
        ),
      ),
    );
  }
}
