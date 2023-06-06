import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/injector.dart';
import 'package:posay/shared/constants/constants.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/unfocus.dart';

class AuthPage extends StatelessWidget {
  static String get path => "/auth";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.gett<AuthBloc>(),
      child: const _AuthPage(),
    );
  }
}

class _AuthPage extends StatefulWidget {
  const _AuthPage();

  @override
  State<_AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<_AuthPage> {
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
                  padding: Constants.edgesAll16,
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: Constants.edgesAll16,
                      labelText: "Username",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: Constants.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: Constants.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      filled: true,
                      fillColor: IColor.background,
                    ),
                  ),
                ),
                Padding(
                  padding: Constants.edgesAll16,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: Constants.edgesAll16,
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: Constants.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: Constants.radiusCircular16,
                        borderSide: BorderSide(color: IColor.tertiary),
                      ),
                      filled: true,
                      fillColor: IColor.background,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLogin(
                              username: usernameController.text,
                              password: passwordController.text,
                              context: context,
                            ),
                          );
                    },
                    child: const Text("LOGIN"))
                // buildIntro(contents),
                // buildIndicator(contents),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get background {
    return Container(
      height: Constants.screenSize.height / 1.8,
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
