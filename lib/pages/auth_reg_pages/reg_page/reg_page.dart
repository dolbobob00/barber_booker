import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/features/reg_as_row.dart';
import 'package:barber_booker/pages/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordConfirmFocus = FocusNode();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerPasswordConfirm =
      TextEditingController();
  TextEditingController textEditingControllerUID = TextEditingController();
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

    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeof.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: NeuroWrapper(
              shape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(16),
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
              Icons.remove_red_eye, color: themeof.colorScheme.secondary,
            ),
            secureText: true,
            labelText: 'password',
            textEditingController: textEditingControllerPassword,
          ),
          MyInputField(
            focusNode: passwordConfirmFocus,
            secureText: true,
            labelText: 'confirm password',
            textEditingController: textEditingControllerPasswordConfirm,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                errorSnackBar(state.error);
              } else if (state is AuthLoginState && state.user != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/home');
                });
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: MyButton(
              func: () {
                if (textEditingControllerPasswordConfirm.text ==
                        textEditingControllerPassword.text &&
                    textEditingControllerEmail.text.isNotEmpty) {
                  try {
                    authBloc.add(
                      RegisterEvent(
                        loginEmail: textEditingControllerEmail.text,
                        password: textEditingControllerPassword.text,
                      ),
                    );
                    emailFocus.unfocus();
                    passwordFocus.unfocus();
                    passwordConfirmFocus.unfocus();
                  } catch (e) {
                    final error = e as FirebaseAuthException;
                    errorSnackBar(
                      error.code,
                    );
                  }
                } else if (textEditingControllerPassword.text !=
                    textEditingControllerPasswordConfirm.text) {
                  errorSnackBar(
                    'Password mismatch',
                  );
                } else if (textEditingControllerEmail.text.isEmpty) {
                  errorSnackBar(
                    'Must have email',
                  );
                }
              },
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              text: 'Register',
            ),
          ),
          InkWell(
            splashColor: themeof.colorScheme.inversePrimary,
            onTap: () => context.go(
              '/login',
            ),
            child: Column(
              children: [
                Text(
                  'Or you already have account?',
                  style: themeof.textTheme.bodySmall!
                      .copyWith(color: themeof.colorScheme.secondary),
                ),
                Text(
                  'Or you is barber?',
                  style: themeof.textTheme.bodySmall!
                      .copyWith(color: themeof.colorScheme.secondary),
                ),
              ],
            ),
          ),
          RegistrationRow(
            iconButtons: [
              MyIconButton(
                icon: Icon(
                  Icons.add_moderator,
                  color: themeof.colorScheme.secondary,
                ),
                func: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          children: [
                            Text(
                              'Are you a barber?',
                              style: themeof.textTheme.bodySmall!.copyWith(
                                  color: themeof.colorScheme.secondary),
                            ),
                            Text(
                              'Input your UID',
                              style: themeof.textTheme.bodySmall!.copyWith(
                                  color: themeof.colorScheme.secondary),
                            ),
                            MyInputField(
                              icon: Icon(
                                Icons.remove_red_eye,
                              ),
                              labelText: 'UID (ask it from manager)',
                              secureText: true,
                              textEditingController: textEditingControllerUID,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyIconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: themeof.colorScheme.secondary,
                                  ),
                                  func: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                MyIconButton(
                                  icon: Icon(
                                    Icons.arrow_circle_right,
                                    color: themeof.colorScheme.secondary,
                                  ),
                                  func: () {
                                    try {
                                      authBloc.add(
                                        SignUpAsAdminEvent(),
                                      );
                                    } catch (e) {
                                      errorSnackBar(
                                        e.toString(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              MyIconButton(
                icon: Icon(
                  Icons.person_add_alt,
                  color: themeof.colorScheme.secondary,
                ),
                func: () {},
              ),
              MyIconButton(
                icon: Icon(
                  Icons.workspace_premium,
                  color: themeof.colorScheme.secondary,
                ),
                func: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
