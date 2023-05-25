part of 'intro_bloc.dart';

abstract class IntroState extends Equatable {
  final List<IntroContent> introContents;
  const IntroState({this.introContents = const []});

  @override
  List<Object> get props => [introContents];
}

// introContents
class IntroLoaded extends IntroState {
  const IntroLoaded({required super.introContents});

  @override
  List<Object> get props => [super.introContents];
}

// INDEX
class IntroIndexChanged extends IntroState {
  final int index;

  const IntroIndexChanged({required super.introContents, required this.index});

  @override
  List<Object> get props => [super.introContents, index];
}

class IntroError extends IntroState {
  final AppError error;

  const IntroError({required this.error});

  @override
  List<Object> get props => [error];
}
