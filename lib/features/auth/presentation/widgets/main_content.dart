import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/widget_style.dart';

class MainContentAuth extends StatelessWidget {
  final _userController = TextEditingController(text: "michael");
  final _passController = TextEditingController(text: "michael123");

  MainContentAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        iconic(200),
        Column(
          children: [
            Padding(
              padding: Const.edgesSymmetricV8H16,
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                  contentPadding: Const.edgesAll16,
                  labelText: context.tr.username,
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  filled: true,
                  fillColor: IColor.background,
                ),
              ),
            ),
            Padding(
              padding: Const.edgesSymmetricV8H16,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextField(
                    obscureText: !state.isShowPass,
                    controller: _passController,
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
                      focusedBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
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
                  style: buttonStylePrimary,
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLogin(
                            username: _userController.text,
                            password: _passController.text,
                            context: context,
                          ),
                        );
                  },
                  child: Text(context.tr.login, style: textStyle),
                ),
              ),
            )
            // buildIntro(contents),
          ],
        ),
        // buildIndicator(contents),
      ],
    );
  }
}
