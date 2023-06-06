import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/usecases/get_intro.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final GetIntro getIntro;
  IntroBloc({required this.getIntro}) : super(const IntroInitState()) {
    on<ChangeIndexIntro>(_changeIndexIntro);
    on<GetIntroListEvent>(_updateContentsIntro);
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
    GetIntroListEvent event,
    Emitter<IntroState> emit,
  ) {
    final introList = getIntro.execute(event.tr);

    emit(IntroContentsUpdated(
      updateContents: state.updateContents + 1,
      index: state.index, 
      introContents: introList,
    ));
  }
}
