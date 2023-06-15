import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'package:posay/shared/extension.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16 + (context.appBarHeightValue / 2),
      ),
      width: 100,
      height: 50,
      child: Row(
        children: [
          const Text("ID"),
          BlocBuilder<LanguageBloc, LanguageState>(builder: languageSwitch),
          const Text("EN")
        ],
      ),
    );
  }

  Widget languageSwitch(BuildContext context, LanguageState state) {
    final currentlanguage = context.localeOf.languageCode;
    return Switch(
      value: currentlanguage == 'en',
      onChanged: (isEnglish) {
        context 
            .read<LanguageBloc>()
            .add(ChangeLanguageEvent(locale: Locale(currentlanguage)));
        context.read<IntroBloc>().add(IntroGetContents(context.tr));
      },
    );
  }
}
