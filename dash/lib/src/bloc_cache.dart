import 'dart:collection';

import 'bloc.dart';

/// Responsible to provide the right bloc class when requested.
class BlocCache {
  HashMap<String, Bloc> blocs = HashMap<String, Bloc>();

  static final BlocCache _singleton = BlocCache._internal();

  factory BlocCache() {
    return _singleton;
  }

  BlocCache._internal();

  /// Provide the bloc class cached with [blocKey] otherwise instantiates with [instance].
  static Bloc getBlocInstance(String blocKey, Function instance) {
    var bloc = BlocCache._singleton.blocs[blocKey];

    if (bloc != null) {
      return bloc;
    }

    bloc = instance();
    BlocCache._singleton.blocs[blocKey] = bloc;

    return bloc;
  }

  static dispose(String blocKey) async {
    BlocCache._singleton.blocs[blocKey]?.dispose();

    BlocCache._singleton.blocs.removeWhere((key, bloc) => blocKey == key);
  }
}
