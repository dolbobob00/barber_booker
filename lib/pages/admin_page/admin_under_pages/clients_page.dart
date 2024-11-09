import 'package:barber_booker/features/client_row.dart';
import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/features/my_list_tile.dart';
import 'package:barber_booker/pages/admin_page/admin_under_pages/concrete_user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/admin_bloc.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminBloc>(context);
    final themeof = Theme.of(context);

    return BlocBuilder<AdminBloc, AdminState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is AdminLoadingState) {
          return CircularProgressIndicator(
            color: themeof.colorScheme.inversePrimary,
            backgroundColor: themeof.colorScheme.inversePrimary,
            strokeWidth: 10,
          );
        }
        if (state is AdminDataState) {
          return ListView(
            children: [
              MyInputField(
                suffix: const Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                labelText: 'SEARCH',
                prefix: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              ...state.basicUsers!.map(
                (e) {
                  return MyListTile(
                    phoneNumber: e['phone'].toString(),
                    extra: e['lastdate'].toString(),
                    role: e['code'].toString(),
                    titleText: Text(
                      e['name'].toString(),
                      style: themeof.textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: themeof.colorScheme.inversePrimary),
                      overflow: TextOverflow.fade,
                    ),
                    // subtitleText: Text(
                    //   e['code'].toString(),
                    //   style: themeof.textTheme.labelSmall,
                    // ),
                    extraIcon: Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserControllPage(
                          uid: e['uid'].toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const Card(
          child: Text('Click floating action button for update...'),
        );
      },
    );

    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('Users').snapshots(),
    //   builder: (context, snapshot) {
    //     List<Widget> clientWidgetsUsers = [];
    //     if (snapshot.hasData) {
    //       final clients = snapshot.data?.docs.reversed.toList();
    //       for (var client in clients!) {
    //         final clientWidget = MyListTile(
    //           titleText: Text(
    //             client['name'],
    //             style: themeof.textTheme.bodyMedium!.copyWith(
    //                 fontSize: 16, color: themeof.colorScheme.inversePrimary),
    //             overflow: TextOverflow.fade,
    //           ),
    //           subtitleText: Text(
    //             'Role: ${client['code']}',
    //             style: themeof.textTheme.labelSmall,
    //           ),
    //           phoneNumber: client['phone'],
    //           lastDate: client['lastdate'],
    //           onTap: () => Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => UserControllPage(
    //                 uid: client['uid'],
    //               ),
    //             ),
    //           ),
    //         );
    //         if (client['code'] == 'user') {
    //           clientWidgetsUsers.add(clientWidget);
    //         }
    //       }
    //     }
    //     return ListView(
    //       children: [
    //         MyInputField(
    //           suffix: Icon(
    //             Icons.filter_list,
    //             color: Colors.black,
    //           ),
    //           labelText: 'SEARCH',
    //           prefix: Icon(
    //             Icons.search,
    //             color: Colors.black,
    //           ),
    //         ),
    //         ...clientWidgetsUsers,
    //       ],
    //     );
    //   },
    // );
  }
}
