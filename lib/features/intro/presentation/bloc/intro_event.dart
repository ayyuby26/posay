part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndexIntro extends IntroEvent {
  final int index;

  const ChangeIndexIntro({required this.index});

  @override
  List<Object> get props => [index];
}

class GetIntroListEvent extends IntroEvent {
  final AppLocalizations tr;
  const GetIntroListEvent(this.tr);

  @override
  List<Object> get props => [tr];
}
