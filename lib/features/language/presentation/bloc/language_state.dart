part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState({required this.locale});

  @override
  List<Object> get props => [locale];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({required super.locale});
}

class LanguageSelected extends LanguageState {
  const LanguageSelected({required super.locale});
}
