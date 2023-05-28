import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'package:posay/injection.dart' as di;

class LanguageSwitch extends StatelessWidget {
  LanguageSwitch({super.key});

  final defaultLang = di.locator<LanguageRepository>().defaultLanguage();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: 100,
      height: 50,
      child: Row(
        children: [
          const Text("ID"),
          BlocBuilder<LanguageBloc, LanguageState>(builder: switchBtn),
          const Text("EN")
        ],
      ),
    );
  }

  Widget switchBtn(BuildContext context, LanguageState state) {
    return Switch(
      value: state.locale.languageCode == defaultLang.code,
      onChanged: (_) {
        context
            .read<LanguageBloc>()
            .add(ChangeLanguageEvent(locale: state.locale));
      },
    );
  }
}
