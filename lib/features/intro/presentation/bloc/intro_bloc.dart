import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:posay/core/app_errors.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';
import '../../data/repositories/intro_repository.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final IntroRepository introRepository;
  IntroBloc({required this.introRepository}) : super(const IntroLoaded()) {
    on<LoadIntroContents>(_loadIntroContents);
    on<ChangeIndexIntro>(_changeIndexIntro);
  }

  FutureOr<void> _loadIntroContents(
    LoadIntroContents event,
    Emitter<IntroState> emit,
  ) async {
    final List<IntroContent> introContents =
        introRepository.getIntroContents(event.context);
    emit(IntroLoaded(introContents: introContents));
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
}
