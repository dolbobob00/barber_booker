import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:barber_booker/domain/constants.dart';
import 'package:barber_booker/extensions/string_extension.dart';
import 'package:barber_booker/features/my_button_text.dart';
import 'package:barber_booker/features/my_input_field.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/features/reg_as_row.dart';
import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_animated_buttons/widgets/pretty_neumorphic_button.dart';

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
      resizeToAvoidBottomInset: true,
      backgroundColor: themeof.colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                            style: themeof.textTheme.bodySmall!.copyWith(
                                color: themeof.colorScheme.inversePrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
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
                      statusHandedPushToDifferentPages(
                        state.status,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    return Divider();
                  },
                  bloc: authBloc,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: MyButton(
                      func: () {
                        if (textEditingControllerPasswordConfirm.text ==
                                textEditingControllerPassword.text &&
                            textEditingControllerEmail.text.isNotEmpty &&
                            textEditingControllerEmail.text.isValidEmail()) {
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
                        } else if (textEditingControllerEmail.text.isEmpty ||
                            !textEditingControllerEmail.text.isValidEmail()) {
                          errorSnackBar(
                            'Check your email.',
                          );
                        }
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.05,
                      text: 'Register',
                      buttonBackgroundColor:
                          const Color.fromRGBO(132, 104, 94, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrettyNeumorphicButton(
                    onPressed: () => context.pushReplacement(
                      '/login',
                    ),
                    label: 'Or you already have account?',
                    labelStyle: themeof.textTheme.bodySmall!.copyWith(
                      color: themeof.colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'UID, Social media registration',
                    style: themeof.textTheme.bodySmall!
                        .copyWith(color: themeof.colorScheme.secondary),
                  ),
                ),
                RegistrationRow(
                  iconButtons: [
                    MyIconButton(
                      icon: SvgPicture.asset(
                        width: 40,
                        height: 40,
                        color: themeof.colorScheme.secondary,
                        assetName,
                        fit: BoxFit.contain,
                        semanticsLabel: 'Barber Logo',
                      ),
                      func: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Column(
                                children: [
                                  Text(
                                    'Are you a barber?',
                                    style: themeof.textTheme.bodySmall!.copyWith(
                                        color: themeof.colorScheme.secondary),
                                  ),
                                  Center(
                                    child: Text(
                                      'Ask admin to create UID for you \nand login with that uid.',
                                      style: themeof.textTheme.bodySmall!
                                          .copyWith(
                                              color:
                                                  themeof.colorScheme.secondary),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                          Navigator.of(context).pop();
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
                        Icons.facebook,
                        size: 36,
                        color: themeof.colorScheme.secondary,
                      ),
                      func: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.165,
                            child: Column(
                              children: [
                                Text(
                                  'Debug version',
                                  style: themeof.textTheme.bodySmall!.copyWith(
                                      color: themeof.colorScheme.secondary),
                                ),
                                Text(
                                  'Facebook/Number phone will be integrated later',
                                  style: themeof.textTheme.bodySmall!.copyWith(
                                      color: themeof.colorScheme.secondary),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MyIconButton(
                      icon: Image.network(
                        'https://avatars.mds.yandex.net/get-mpic/5283728/img_id7358523481806022349.png/orig',
                        scale: 36,
                        color: themeof.colorScheme.secondary,
                      ),
                      func: () => authBloc.add(
                        SignUpByGoogleEvent(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
