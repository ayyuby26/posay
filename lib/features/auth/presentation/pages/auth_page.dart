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
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
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
                  ),
                ),
                Padding(
                  padding: Const.edgesAll16,
                  child: SizedBox(
                    width: Const.screenSize.width,
                    child: TextButton(
                        style: TextButton.styleFrom(
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
                        child: Text(context.tr.login)),
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
