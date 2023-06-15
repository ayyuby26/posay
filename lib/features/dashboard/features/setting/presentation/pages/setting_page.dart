import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/widget_style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SsettingPageState();
}

class SsettingPageState extends State<SettingPage> {
  @override
  void initState() {
    final isEmpty = context.read<AuthBloc>().state.user == null;
    if (isEmpty) context.read<AuthBloc>().add(AuthGetLocalUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background,
          const SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: LanguageSwitch(),
                ),
                Profile(),
                Btn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: IColor.tertiary.withOpacity(.2)),
        borderRadius: Const.radiusCircular8,
      ),
      margin: Const.edgesAll16,
      padding: Const.edgesAll16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${context.tr.welcome},",
                style: TextStyle(color: IColor.secondary),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Text(
                    state.user?.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          Icon(
            Icons.person_4_rounded,
            size: 50,
            color: IColor.primary,
          ),
        ],
      ),
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: Const.edgesAll16,
          alignment: Alignment.centerLeft,
          backgroundColor: Colors.red[600],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          context.okCancel(
            foregroundColorOk: Colors.red,
            title: context.tr.logoutConfirmTitle,
            content: context.tr.logoutConfirmContent,
            titleOk: context.tr.logout,
            onPressed: () {
              final authBloc = context.read<AuthBloc>();
              authBloc.add(AuthLogout());
              if (authBloc.state.status.isSuccess) {
                context.closeDialog();
                context.pushReplacement(AuthPage.path);
              }
            },
          );
        },
        child: Row(
          children: [
            const Icon(
              Icons.output,
              color: Colors.white,
            ),
            Const.width16,
            Text(
              context.tr.logout,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
