// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  static T of<T extends Bloc>() {
    switch (T) {
      case MyBloc1:
        {
          return BlocCache.getBlocInstance("MyBloc1", () => MyBloc1.instance());
        }
      case MyBloc2:
        {
          return BlocCache.getBlocInstance("MyBloc2", () => MyBloc2.instance());
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case MyBloc1:
        {
          BlocCache.dispose("MyBloc1");
          break;
        }
      case MyBloc2:
        {
          BlocCache.dispose("MyBloc2");
          break;
        }
    }
  }
}
