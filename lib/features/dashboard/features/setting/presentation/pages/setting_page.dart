import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/pop_up.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment: Alignment.centerRight, child: LanguageSwitch()),
            const Profile(),
            const Btn(),
          ],
        ),
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
        children: [
          // const Icon(Icons.person_pin_rounded),
          // Const.sizedBoxW8,
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
          PopUp.okCancel(
            foregroundColorOk: Colors.red,
            context: context,
            title: context.tr.logoutConfirmTitle,
            content: context.tr.logoutConfirmContent,
            titleOk: context.tr.logout,
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout(context));
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
