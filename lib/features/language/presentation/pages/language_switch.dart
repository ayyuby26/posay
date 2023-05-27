import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/language/domain/repositories/language_repository.dart';
import 'package:posay/features/language/presentation/bloc/language_bloc.dart';
import 'package:posay/injection.dart' as di;

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Scaffold(
        body: SizedBox(
          width: 100,
          child: Row(
            children: [
              const Text("ID"),
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return Switch(
                      value: state.locale.languageCode ==
                          di
                              .locator<LanguageRepository>()
                              .defaultLanguage()
                              .code,
                      onChanged: (_) {
                        context
                            .read<LanguageBloc>()
                            .add(ChangeLanguageEvent(locale: state.locale));
                      });
                },
              ),
              const Text("EN")
            ],
          ),
        ),
      ),
    );
  }
}
