// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_management.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  static T of<T extends Bloc>() {
    switch (T) {
      case MyHomeBloc:
        {
          return BlocCache.getBlocInstance(
              "MyHomeBloc", () => MyHomeBloc.instance());
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case MyHomeBloc:
        {
          BlocCache.dispose("MyHomeBloc");
          break;
        }
    }
  }
}
