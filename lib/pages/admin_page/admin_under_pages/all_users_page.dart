import 'package:barber_booker/features/my_list_tile.dart';
import 'package:barber_booker/pages/admin_page/admin_under_pages/concrete_user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/admin_bloc.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminBloc>(context);
    final themeof = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "All users below",
          ),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                List<MyListTile> clientWidgetsUsers = [];
                List<MyListTile> clientWidgetsAdmins = [];
                List<MyListTile> clientWidgetsBarbers = [];
                if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  for (var client in clients!) {
                    final clientWidget = MyListTile(
                      titleText: Text(
                        client['name'],
                      ),
                      subtitleText: Text(
                        'Role: ${client['code']}',
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserControllPage(
                            uid: client['uid'],
                          ),
                        ),
                      ),
                    );
                    if (client['code'] == 'user') {
                      clientWidgetsUsers.add(clientWidget);
                    } else if (client['code'] == 'barber') {
                      clientWidgetsBarbers.add(clientWidget);
                    } else if (client['code'] == 'admin') {
                      clientWidgetsAdmins.add(clientWidget);
                    }
                  }
                }
                return Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'ADMINS BELOW: ',
                          style: themeof.textTheme.titleLarge!.copyWith(
                            color: themeof.colorScheme.secondary,
                          ),
                        ),
                      ),
                      ...clientWidgetsAdmins,
                      clientWidgetsAdmins.isEmpty
                          ? const MyListTile(
                              titleText: Text(
                                "No barber's",
                              ),
                            )
                          : Container(),
                      Center(
                        child: Text(
                          'BARBERS BELOW: ',
                          style: themeof.textTheme.titleLarge!.copyWith(
                            color: themeof.colorScheme.surface,
                          ),
                        ),
                      ),
                      ...clientWidgetsBarbers,
                      clientWidgetsBarbers.isEmpty
                          ? const MyListTile(
                              titleText: Text(
                                "No barber's",
                              ),
                            )
                          : Container(),
                      Center(
                        child: Text(
                          'USERS BELOW: ',
                          style: themeof.textTheme.titleLarge!.copyWith(
                            color: themeof.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      clientWidgetsUsers.isEmpty
                          ? const MyListTile(
                              titleText: Text(
                                "No barber's",
                              ),
                            )
                          : Container(),
                      ...clientWidgetsUsers,
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
