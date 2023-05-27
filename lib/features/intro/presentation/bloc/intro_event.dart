part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

// LOAD DESCRIPTION INTRO
// class LoadIntroContents extends IntroEvent {
//   final AppLocalizations appLocalizations;

//   const LoadIntroContents({required this.appLocalizations});

//   @override
//   List<Object> get props => [appLocalizations];
// }

// CHANGE INDEX
class ChangeIndexIntro extends IntroEvent {
  final int index;

  const ChangeIndexIntro({required this.index});

  @override
  List<Object> get props => [index];
}

class UpdateContentsIntro extends IntroEvent {
  const UpdateContentsIntro();
}
