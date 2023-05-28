import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';
import '../../data/repositories/intro_repository.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final IntroRepository introRepository;
  IntroBloc({required this.introRepository}) : super(const IntroLoaded()) {
    on<ChangeIndexIntro>(_changeIndexIntro);
    on<UpdateContentsIntro>(_updateContentsIntro);
  }

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
