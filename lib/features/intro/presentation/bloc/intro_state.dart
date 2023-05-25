part of 'intro_bloc.dart';

abstract class IntroState extends Equatable {
  final List<IntroContent> introContents;
  final int index;
  const IntroState({this.introContents = const [], this.index = 0});

  @override
  List<Object> get props => [];
}

// LOAD DESCRIPTION INTRO
class IntroLoaded extends IntroState {
  const IntroLoaded({super.introContents});

  @override
  List<Object> get props => [introContents];
}

// CHANGE INDEX
class IntroIndexChanged extends IntroState {
  const IntroIndexChanged({required super.introContents, required super.index});

  @override
  List<Object> get props => [introContents, index];
}
