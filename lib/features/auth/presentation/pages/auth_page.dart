import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/unfocus.dart';

class AuthPage extends StatefulWidget {
  static String get path => "/auth";
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Unfocus(
        child: Stack(
          children: [
            background,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: Const.edgesAll16,
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: Const.edgesAll16,
                      labelText: context.tr.username,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: Const.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: Const.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      filled: true,
                      fillColor: IColor.background,
                    ),
                  ),
                ),
                Padding(
                  padding: Const.edgesAll16,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return TextFormField(
                        obscureText: !state.isShow,
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthShowPassEvent());
                            },
                            icon: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return Icon(
                                  state.isShow
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                );
                              },
                            ),
                          ),
                          contentPadding: Const.edgesAll16,
                          labelText: context.tr.password,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: Const.radiusCircular16,
                            borderSide: BorderSide(color: IColor.tertiary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: Const.radiusCircular16,
                            borderSide: BorderSide(color: IColor.tertiary),
                          ),
                          filled: true,
                          fillColor: IColor.background,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: Const.edgesAll16,
                  child: SizedBox(
                    width: Const.screenSize.width,
                    height: 55,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: IColor.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: Const.radiusCircular16,
                          ),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  context: context,
                                ),
                              );
                        },
                        child: Text(
                          context.tr.login,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                )
                // buildIntro(contents),
                // buildIndicator(contents),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: LanguageSwitch(),
            ),
          ],
        ),
      ),
    );
  }

  Widget get background {
    return Container(
      height: Const.screenSize.height / 1.8,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            IColor.background.withOpacity(.0),
            IColor.background.withOpacity(.9),
          ],
        ),
      ),
      child: Image.asset(
        "assets/background.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
