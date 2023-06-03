part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInit extends LanguageState {
  const LanguageInit();
}

class LanguageUpdateState extends LanguageState {
  final Locale locale;
  const LanguageUpdateState({required this.locale});

  @override
  List<Object> get props => [locale];
}
