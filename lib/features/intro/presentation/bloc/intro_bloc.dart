import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';
import '../../data/repositories/intro_repository.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final IntroRepository introRepository;
  IntroBloc({required this.introRepository}) : super(const IntroLoaded()) {
    // on<LoadIntroContents>(_loadIntroContents);
    on<ChangeIndexIntro>(_changeIndexIntro);
    on<UpdateContentsIntro>(_updateContentsIntro);
  }

  // FutureOr<void> _loadIntroContents(
  //   LoadIntroContents event,
  //   Emitter<IntroState> emit,
  // ) async {
  //   final List<IntroContent> introContents =
  //       introRepository.getIntroContents(event.appLocalizations);
  //   emit(IntroLoaded(introContents: introContents));
  // }

  FutureOr<void> _changeIndexIntro(
    ChangeIndexIntro event,
    Emitter<IntroState> emit,
  ) {
    emit(IntroIndexChanged(
      index: event.index,
      introContents: state.introContents,
    ));
  }

  FutureOr<void> _updateContentsIntro(
    UpdateContentsIntro event,
    Emitter<IntroState> emit,
  ) {
    emit(IntroContentsUpdated(
      updateContents: state.updateContents + 1,
      index: state.index,
      introContents: state.introContents,
    ));
  }
}