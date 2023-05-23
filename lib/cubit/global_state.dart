part of 'global_cubit.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();

  @override
  List<Object> get props => [];
}

class GlobalInitial extends GlobalState {
  final Locale locale;
  const GlobalInitial({required this.locale});

  GlobalInitial clone(Locale? locale) {
    return GlobalInitial(locale: locale ?? this.locale);
  }
}
