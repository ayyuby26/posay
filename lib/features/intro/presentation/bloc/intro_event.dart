part of 'intro_bloc.dart';

sealed class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

class IntroChangeIndex extends IntroEvent {
  final int index;

  const IntroChangeIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class IntroGetContents extends IntroEvent {
  final AppLocalizations tr;
  const IntroGetContents(this.tr);

  @override
  List<Object> get props => [tr];
}

class IntroSetAsSeen extends IntroEvent {
  final Intro intro;

  const IntroSetAsSeen(this.intro);

  @override
  List<Object> get props => [intro];
}

class IntroIsSeen extends IntroEvent {}
