// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  static T of<T extends Bloc>([List<String> keepBlocs = const []]) {
    switch (T) {
      case MyBloc1:
        {
          return BlocProviderCache.getBlocInstance(
              keepBlocs, MyBloc1.key, () => MyBloc1.instance());
        }
      case MyBloc2:
        {
          return BlocProviderCache.getBlocInstance(
              keepBlocs, MyBloc2.key, () => MyBloc2.instance());
        }
    }
    return null;
  }
}
