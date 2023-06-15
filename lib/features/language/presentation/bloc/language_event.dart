part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LoadLanguageEvent extends LanguageEvent {
  const LoadLanguageEvent();
}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale locale;
  const ChangeLanguageEvent({required this.locale});

  @override
  List<Object> get props => [locale];
}

class LanguageGetDefault extends LanguageEvent {}
