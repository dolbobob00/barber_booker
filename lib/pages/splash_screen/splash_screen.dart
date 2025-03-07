import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../features/neuro_wrapper.dart';
import '../auth_bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context)
      ..add(
        CheckLogedInEvent(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocListener<AuthBloc, AuthState>(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is AuthLoginState) {
                if (state.user != null) {
                  if (mounted) {
                    context.go('/home');
                  }
                } else if (state.user == null) {
                  Future.delayed(
                    const Duration(seconds: 3),
                  ).whenComplete(
                    () {
                      if (mounted) {
                        context.go('/afterSplash');
                      }
                    },
                  );
                }
              }
            },
            child: Container(),
          ),
          Center(
            child: NeuroWrapper(
              shape: const NeumorphicBoxShape.circle(),
              widget: Padding(
                padding: const EdgeInsets.all(56),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(
                    'assets/icons/splash_screen/main.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          NeuroWrapper(
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicText(
                "Barber app\n u aura will be 10000+",
                style: NeumorphicStyle(
                  depth: 4, //customize depth here
                  color: Theme.of(context)
                      .colorScheme
                      .secondary, //customize color here
                ),
                textStyle: NeumorphicTextStyle(
                  fontFamily: 'Unifraktur',
                  fontSize: 36, //customize size here
                  // AND othrs usual text style properties (fontFamily, fontWeight, ...)
                ),
              ),
            ),
            shape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(
                16,
              ),
            ),
          ),
          Switch.adaptive(
            value: Hive.box('app_settings').get('isLight'),
            onChanged: (value) =>
                Hive.box('app_settings').put('isLight', value),
          ),
        ],
      ),
    );
  }
}
