part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  final String message;
  const LanguageState({this.message = ""});

  @override
  List<Object> get props => [message];
}

class LanguageInit extends LanguageState {
  const LanguageInit({super.message});
}

class LanguageUpdateState extends LanguageState {
  final Locale locale;
  const LanguageUpdateState({required this.locale, super.message});

  @override
  List<Object> get props => [locale];
}
