import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
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
              },
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              text: 'Login as user',
            ),
          ),
          InkWell(
            splashColor: themeof.colorScheme.inversePrimary,
            onTap: () => context.go(
              '/registration',
            ),
            child: Text(
              'Or you a newbie here?',
              style: themeof.textTheme.bodySmall!
                  .copyWith(color: themeof.colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
