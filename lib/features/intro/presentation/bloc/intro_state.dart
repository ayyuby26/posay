part of 'intro_bloc.dart';

abstract class IntroState extends Equatable {
  final List<IntroModel> introContents;
  final int index;
  final int updateContents;

  const IntroState({
    this.introContents = const [],
    this.index = 0,
    this.updateContents = 0,
  });

  @override
  List<Object> get props => [introContents, index, updateContents];
}

// LOAD DESCRIPTION INTRO
class IntroLoaded extends IntroState {
  const IntroLoaded({super.introContents});
}

// CHANGE INDEX
class IntroIndexChanged extends IntroState {
  const IntroIndexChanged({
    required super.introContents,
    required super.index,
  });
}

// CHANGE INDEX
class IntroContentsUpdated extends IntroState {
  const IntroContentsUpdated({
    required super.introContents,
    required super.index,
    required super.updateContents,
  });
}
