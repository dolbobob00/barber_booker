import 'package:barber_booker/features/my_list_tile.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("USER PAGE"),
      ),
      drawer: Drawer(
        // width: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: themeof.colorScheme.primary,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.person,
                color: themeof.colorScheme.secondary,
                size: 64,
              ),
            ),
            NeuroWrapper(
              shape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(16),
              ),
              widget: MyListTile(
                titleText: BlocBuilder<AuthBloc, AuthState>(
                  bloc: authBloc,
                  builder: (context, state) {
                    if (state is AuthLoginState) {
                      return Text(
                        'Hello, ${state.user!.displayName ?? state.user!.email!}',
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            const MyListTile(),
          ],
        ),
      ),
      body: const Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authBloc.add(
            SignOutEvent(),
          );
        },
      ),
    );
  }
}
