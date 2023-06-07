import 'package:flutter/cupertino.dart';
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
  final usernameController = TextEditingController(text: "michael");
  final passwordController = TextEditingController(text: "michael123");

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
                  padding: Const.edgesSymmetricV8H16,
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
                  padding: Const.edgesSymmetricV8H16,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return TextFormField(
                        obscureText: !state.isShowPass,
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthShowPassEvent());
                            },
                            icon: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return Icon(
                                  state.isShowPass
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
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: Colors.black38,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: Const.radiusCircular16,
                          color: Colors.white,
                        ),
                        child: const CupertinoActivityIndicator(),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
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
