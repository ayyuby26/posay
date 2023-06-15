import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/usecases/get_intro.dart';
import 'package:posay/features/intro/domain/usecases/is_intro_seen.dart';
import 'package:posay/features/intro/domain/usecases/save_intro.dart';
import 'package:posay/shared/failure.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final GetIntro _getIntro;
  final IsIntroSeen _isIntroSeen;
  final SaveIntro _saveIntro;

  IntroBloc(
    this._getIntro,
    this._isIntroSeen,
    this._saveIntro,
  ) : super(const IntroState()) {
    on<IntroChangeIndex>(_changeIndexIntro);
    on<IntroGetContents>(_getIntroListEvent);
    on<IntroSetAsSeen>(_introSaveToLocal);
    on<IntroIsSeen>(_introIsSeen);
  }

  FutureOr<void> _changeIndexIntro(
    IntroChangeIndex event,
    Emitter<IntroState> emit,
  ) {
    emit(state.copyWith(
      index: event.index,
      introContents: state.introContents,
    ));
  }

  _getIntroListEvent(IntroGetContents event, Emitter<IntroState> emit) {
    final introList = _getIntro.execute(event.tr);

    introList.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => emit(state.copyWith(
        updateContents: state.updateContents + 1,
        index: state.index,
        introContents: r,
      )),
    );
  }

  _introSaveToLocal(IntroSetAsSeen event, Emitter<IntroState> emit) {
    final result = _saveIntro.execute(event.intro);

    result.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => emit(state.copyWith(isIntroSeen: r)),
    );
  }

  _introIsSeen(IntroIsSeen event, Emitter<IntroState> emit) {
    final result = _isIntroSeen.execute();
    result.fold(
      (l) => emit(state.copyWith(failure: l)),
      (r) => emit(state.copyWith(isIntroSeen: r)),
    );
  }
}
