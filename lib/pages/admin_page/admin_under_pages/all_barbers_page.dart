import 'package:barber_booker/features/reg_as_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/my_input_field.dart';
import '../../../features/my_list_tile.dart';
import '../bloc/admin_bloc.dart';
import 'concrete_barber_page.dart';
import 'concrete_user_page.dart';

class AllBarbersPage extends StatelessWidget {
  const AllBarbersPage({super.key});

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
                suffix: InkWell(
                  splashColor: themeof.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(
                    24,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        insetPadding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.13,
                          vertical: MediaQuery.of(context).size.height * 0.39,
                        ),
                        backgroundColor: themeof.colorScheme.surface,
                        child: Column(
                          children: [
                            const Text(
                              'Are you sure want to generate barber credential?',
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                MyIconButton(
                                  icon: Icon(
                                    size: 33,
                                    Icons.close,
                                    color: themeof.colorScheme.secondary,
                                  ),
                                  func: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                MyIconButton(
                                  icon: Icon(
                                    size: 33,
                                    Icons.add_circle,
                                    color: themeof.colorScheme.secondary,
                                  ),
                                  func: () {
                                    Navigator.of(context).pop();
                                    bloc.add(
                                      AdminCreateBarberEvent(),
                                    );
                                    Future.delayed(
                                      Duration(seconds: 1, milliseconds: 500),
                                    ).whenComplete(
                                      () {
                                        bloc.add(
                                          AdminGetUsersEvent(),
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
                labelText: 'SEARCH',
                prefix: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              ...state.barberUsers!.map(
                (e) {
                  return MyListTile(
                    phoneNumber: e['phone'].toString(),
                    role: e['code'].toString(),
                    extra: "${e['specialUidCode']} - auth code",
                    titleText: Text(
                      e['name'].toString(),
                      style: themeof.textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: themeof.colorScheme.inversePrimary),
                      overflow: TextOverflow.fade,
                    ),
                    subtitleText: Text(
                      e['code'].toString(),
                      style: themeof.textTheme.labelSmall,
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BarberControllPage(
                          uid: e['uid'].toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              ...state.adminUsers!.map(
                (e) {
                  return MyListTile(
                    phoneNumber: e['phone'].toString(),
                    role: e['code'].toString(),
                    titleText: Text(
                      e['name'].toString(),
                      style: themeof.textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: themeof.colorScheme.inversePrimary),
                      overflow: TextOverflow.fade,
                    ),
                    extra: 'Role: ${e['code']}',
                    extraIcon: Icon(
                      Icons.support_agent,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Text(
                          'No profile provided',
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
  }
}
