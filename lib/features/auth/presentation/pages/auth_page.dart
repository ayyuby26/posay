import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/auth/presentation/widgets/main_content.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/unfocus.dart';
import 'package:posay/shared/widget_style.dart';

class AuthPage extends StatefulWidget {
  static String get path => "/auth";
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) context.loading;
          if (state is AuthLoginFailure) {
            context.ok(title: 'Oops', content: state.message);
          }
        },
        child: Unfocus(
          child: Stack(
            children: [
              background,
              MainContentAuth(),
              Align(alignment: Alignment.topRight, child: LanguageSwitch()),
            ],
          ),
        ),
      ),
    );
  }
}
