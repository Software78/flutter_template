import 'package:bloc/bloc.dart';
import 'package:sprintf/sprintf.dart';

import 'logger.dart';

class AppBlocObserver extends BlocObserver {
   @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    DebugLogger.log('onEvent ', '${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    DebugLogger.log('onChange', change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    DebugLogger.log(
      'onTransition',
      sprintf('%s => %s', <String>[
        transition.currentState.toString(),
        transition.nextState.toString()
      ]),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    DebugLogger.log('onError', '${bloc.runtimeType}, $error, $stackTrace');
  }
}
