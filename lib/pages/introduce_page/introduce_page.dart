import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';

import '../../features/my_button_text.dart';

class IntroducePage extends StatelessWidget {
  const IntroducePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocLogin = BlocProvider.of<AuthBloc>(context);
    final themeof = Theme.of(context);
    return Scaffold(
      backgroundColor: themeof.colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: NeuroWrapper(
                widget: Padding(
                  padding: const EdgeInsets.all(
                    25,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        color: themeof.colorScheme.inversePrimary,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        'There can be your ads or logo',
                        style: themeof.textTheme.bodySmall!.copyWith(
                            color: themeof.colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                shape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(
                    25,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: NeuroWrapper(
                      widget: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                text: 'Premium barber\'s.',
                              ),
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                text:
                                    '\n Our skilled barbers deliver precision cuts and beard grooming, using only the finest products to ensure quality and satisfaction. \n With a welcoming atmosphere and personalized service, every visit feels relaxing and enjoyable',
                              ),
                              TextSpan(
                                text: '\n Choose us for a cut above the rest.',
                                style: themeof.textTheme.bodySmall!.copyWith(
                                  color: themeof.colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      shape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyButton(
                          func: () => context.push('/login'),
                          text: 'Login now',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          func: () => context.push(
                            '/registration',
                          ),
                          text: 'Or you a newbie here?',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
