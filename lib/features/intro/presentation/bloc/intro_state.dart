part of 'intro_bloc.dart';

final class IntroState extends Equatable {
  final List<Intro> introContents;
  final int index;
  final int updateContents;
  final Failure? failure;
  final bool isIntroSeen;

  const IntroState({
    this.isIntroSeen = false,
    this.failure,
    this.introContents = const [],
    this.index = 0,
    this.updateContents = 0,
  });

  @override
  List<Object?> get props => [
        isIntroSeen,
        failure,
        introContents,
        index,
        updateContents,
      ];

  IntroState copyWith({
    bool? isIntroSeen,
    List<Intro>? introContents,
    int? index,
    int? updateContents,
    Failure? failure,
  }) {
    return IntroState(
      isIntroSeen: isIntroSeen ?? this.isIntroSeen,
      introContents: introContents ?? this.introContents,
      index: index ?? this.index,
      updateContents: updateContents ?? this.updateContents,
      failure: failure,
    );
  }
}
