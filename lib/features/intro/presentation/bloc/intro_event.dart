part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

// LOAD DESCRIPTION INTRO
class LoadIntroContents extends IntroEvent {
  final BuildContext context;

  const LoadIntroContents({required this.context});

  @override
  List<Object> get props => [context];
}

// CHANGE INDEX
class ChangeIndexIntro extends IntroEvent {
  final int index;

  const ChangeIndexIntro({required this.index});

  @override
  List<Object> get props => [index];
}