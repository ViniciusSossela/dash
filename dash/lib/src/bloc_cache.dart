import 'dart:collection';

import 'bloc.dart';

class BlocCache {
  HashMap<String, Bloc> blocs = HashMap<String, Bloc>();

  static final BlocCache _singleton = BlocCache._internal();

  factory BlocCache() {
    return _singleton;
  }

  BlocCache._internal();

  static Bloc getBlocInstance(String blocKey, Function instance) {
    var bloc = BlocCache._singleton.blocs[blocKey];

    if (bloc != null) {
      return bloc;
    }

    bloc = instance();
    BlocCache._singleton.blocs[blocKey] = bloc;

    return bloc;
  }

  static disposeAllAndKeep(List<String> blocKeys) async {
    BlocCache._singleton.blocs.forEach((key, bloc) {
      if (!blocKeys.contains(key)) bloc.dispose();
    });

    BlocCache._singleton.blocs
        .removeWhere((key, bloc) => !blocKeys.contains(key));
  }

  static dispose(String blocKey) async {
    BlocCache._singleton.blocs[blocKey]?.dispose();

    BlocCache._singleton.blocs.removeWhere((key, bloc) => blocKey == key);
  }

  static disposeAll() async {
    BlocCache._singleton.blocs.forEach((key, bloc) {
      bloc.dispose();
    });

    BlocCache._singleton.blocs.clear();
  }
}
