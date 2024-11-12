import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:barber_booker/extensions/string_extension.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_animated_buttons/widgets/pretty_neumorphic_button.dart';

import '../../../domain/constants.dart';
import '../../../features/reg_as_row.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerCodeUnique =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    void errorSnackBar(String error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Registration error!',
            message: error,
            contentType: ContentType.failure,
          ),
        ),
      );
    }

    statusHandedPushToDifferentPages(String status) {
      print('Push');
      if (status == 'none') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            context.go('/register');
          },
        );
      } else if (status == 'user') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            context.go('/home');
          },
        );
      } else if (status == 'barber') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            context.go('/barber_page');
          },
        );
      } else if (status == 'admin') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            context.go('/admin_page');
          },
        );
      }
    }

    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: themeof.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: NeuroWrapper(
              shape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(
                  16,
                ),
              ),
              widget: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      'assets/img/logo.png',
                      color: themeof.colorScheme.inversePrimary,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'There can be your ads or logo',
                      style: themeof.textTheme.bodySmall!
                          .copyWith(color: themeof.colorScheme.inversePrimary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          MyInputField(
            focusNode: emailFocus,
            icon: Icon(
              Icons.email,
              color: themeof.colorScheme.secondary,
            ),
            labelText: 'email',
            textEditingController: textEditingControllerEmail,
          ),
          MyInputField(
            focusNode: passwordFocus,
            icon: Icon(
              Icons.remove_red_eye,
              color: themeof.colorScheme.secondary,
            ),
            secureText: true,
            labelText: 'password',
            textEditingController: textEditingControllerPassword,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                errorSnackBar(state.error);
              } else if (state is AuthLoginState && state.user != null) {
                print('Should check state state');
                statusHandedPushToDifferentPages(
                  state.status,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              return Container();
            },
            bloc: authBloc,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegistrationRow(
                iconButtons: [
                  MyIconButton(
                    icon: Row(
                      children: [
                        SvgPicture.asset(
                          width: 36,
                          height: 36,
                          color: themeof.colorScheme.secondary,
                          assetName,
                          fit: BoxFit.contain,
                          semanticsLabel: 'Barber Logo',
                        ),
                        Text(
                          ' - for barber\'s',
                          style: themeof.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    func: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:
                                MediaQuery.of(context).size.height * 0.16 + 24,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<AuthBloc, AuthState>(
                                bloc: authBloc,
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }

                                  return Column(
                                    children: [
                                      Text(
                                        'Are you a barber?',
                                        style: themeof.textTheme.bodySmall!
                                            .copyWith(
                                                color: themeof
                                                    .colorScheme.secondary),
                                      ),
                                      MyInputField(
                                        textEditingController:
                                            textEditingControllerCodeUnique,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MyIconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color:
                                                  themeof.colorScheme.secondary,
                                            ),
                                            func: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MyButton(
                                              func: () {
                                                if (textEditingControllerCodeUnique
                                                    .text.isNotEmpty) {
                                                  try {
                                                    authBloc.add(
                                                      SignUpByCodeEvent(
                                                        specialUid:
                                                            textEditingControllerCodeUnique
                                                                .text,
                                                      ),
                                                    );
                                                  } on Exception catch (e) {
                                                    errorSnackBar(
                                                      e.toString(),
                                                    );
                                                  }
                                                } else {
                                                  errorSnackBar(
                                                    'Input the code!',
                                                  );
                                                }
                                              },
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              text: 'Login as barber',
                                              buttonBackgroundColor:
                                                  const Color.fromRGBO(
                                                      132, 104, 94, 1),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: MyButton(
                  func: () {
                    if (textEditingControllerEmail.text.isValidEmail()) {
                      try {
                        authBloc.add(
                          LogInEvent(
                              loginEmail: textEditingControllerEmail.text,
                              password: textEditingControllerPassword.text),
                        );
                        emailFocus.unfocus();
                        passwordFocus.unfocus();
                      } catch (e) {
                        final error = e as FirebaseAuthException;
                        errorSnackBar(
                          error.code,
                        );
                      }
                    } else {
                      errorSnackBar(
                        'Check your email',
                      );
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.05,
                  text: 'Login',
                  buttonBackgroundColor: const Color.fromRGBO(132, 104, 94, 1),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrettyNeumorphicButton(
              onPressed: () => context.pushReplacement('/registration'),
              label: 'Or you a newbie here?',
              labelStyle: themeof.textTheme.bodySmall!.copyWith(
                color: themeof.colorScheme.inversePrimary,
                fontSize: 19,
              ),
            ),
          ),
          // InkWell(
          //   splashColor: themeof.colorScheme.inversePrimary,
          //   onTap: () => context.go(
          //     '/registration',
          //   ),
          //   child: Text(
          //     'Or you a newbie here?',
          //     style: themeof.textTheme.bodySmall!
          //         .copyWith(color: themeof.colorScheme.secondary),
          //   ),
          // ),
        ],
      ),
    );
  }
}
