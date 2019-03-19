import 'package:dash/dash.dart';

import 'dash_example.dart';

/// This is automaticly generated...
class Provider {
  static T of<T extends Bloc>() {
    switch (T) {
      case BlocSample:
        {
          return BlocCache.getBlocInstance(
              'BlocSample', () => BlocSample.instance());
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case BlocSample:
        {
          BlocCache.dispose("BlocSample");
          break;
        }
    }
  }
}
