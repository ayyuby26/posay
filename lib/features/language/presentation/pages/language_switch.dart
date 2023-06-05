import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'package:posay/injection.dart';
import 'package:posay/shared/extension.dart';

class LanguageSwitch extends StatelessWidget {
  LanguageSwitch({super.key});

  final defaultLang = Injection().locator<LanguageRepository>().defaultLanguage();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16 + (height / 2)),
      width: 100,
      height: 50,
      child: Row(
        children: [
          const Text("ID"),
          BlocBuilder<LanguageBloc, LanguageState>(builder: langSwitch),
          const Text("EN")
        ],
      ),
    );
  }

  Widget langSwitch(BuildContext context, LanguageState state) {
    final current = context.localeOf.languageCode;
    return Switch(
      value: current == defaultLang.code,
      onChanged: (isEnglish) {
        context
            .read<LanguageBloc>()
            .add(ChangeLanguageEvent(locale: Locale(current)));
      },
    );
  }
}
