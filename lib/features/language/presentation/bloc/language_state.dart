part of 'language_bloc.dart';

final class LanguageState extends Equatable {
  final Failure? failure;
  final Locale? languageSelected;
  final Language? defaultLanguage;

  const LanguageState({
    this.failure,
    this.languageSelected,
    this.defaultLanguage,
  });

  @override
  List<Object?> get props => [
        failure,
        languageSelected,
        defaultLanguage,
      ];

  LanguageState copyWith({
    Failure? failure,
    Locale? languageSelected,
    Language? defaultLanguage,
  }) {
    return LanguageState(
      failure: failure ?? this.failure,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      languageSelected: languageSelected ?? this.languageSelected,
    );
  }
}
