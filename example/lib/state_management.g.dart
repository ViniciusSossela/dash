// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_management.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  @override
  T of<T extends Bloc>() {
    switch (T) {
      case MyHomeBloc:
        {
          return BlocCache.getBlocInstance(
              'MyHomeBloc', () => MyHomeBloc.instance()) as T;
        }
    }
    throw Exception('Bloc not found');
  }

  @override
  void dispose<T extends Bloc>() {
    switch (T) {
      case MyHomeBloc:
        {
          BlocCache.dispose('MyHomeBloc');
          break;
        }
    }
  }
}
