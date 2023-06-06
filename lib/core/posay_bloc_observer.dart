import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/shared/print.dart';

class PosayBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Print.red('${bloc.runtimeType} • $error » $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    Print.toska("${bloc.runtimeType} • $change");
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    Print.orangeBG('${bloc.runtimeType}');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    Print.orange('OnCreate: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    Print.white("onEvent • ${bloc.runtimeType} » $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Print.purple("${bloc.runtimeType} • $transition");
    super.onTransition(bloc, transition);
  }
}
