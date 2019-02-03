// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  static T of<T extends Bloc>([List<String> keepBlocs = const []]) {
    switch (T) {
      case BlocExample:
        {
          return BlocCache.getBlocInstance(
              keepBlocs, BlocExample.key, () => BlocExample.instance());
        }
    }
    return null;
  }
}
