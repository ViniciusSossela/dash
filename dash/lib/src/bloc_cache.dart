import 'dart:collection';

import 'bloc.dart';

class BlocCache {
  HashMap<String, Bloc> blocs = HashMap<String, Bloc>();

  static final BlocCache _singleton = BlocCache._internal();

  factory BlocCache() {
    return _singleton;
  }

  BlocCache._internal();

  static Bloc getBlocInstance(
      List<String> keepBlocs, String blocKey, Function instance) {
    var bloc = BlocCache._singleton.blocs[blocKey];
    List<String> listKeepBlocs;
    if (!keepBlocs.contains(blocKey))
      listKeepBlocs = List.from(keepBlocs)..add(blocKey);

    if (bloc != null) {
      _disposeAllAndKeep(listKeepBlocs);
      return bloc;
    }

    bloc = instance();
    BlocCache._singleton.blocs[blocKey] = bloc;
    _disposeAllAndKeep(listKeepBlocs);

    return bloc;
  }

  static _disposeAllAndKeep(List<String> blocKeys) async {
    BlocCache._singleton.blocs.forEach((key, bloc) {
      if ((bloc.disposable() == null || bloc.disposable()) &&
          !blocKeys.contains(key)) bloc.dispose();
    });

    BlocCache._singleton.blocs.removeWhere((key, bloc) =>
        (bloc.disposable() == null || bloc.disposable()) &&
        !blocKeys.contains(key));
  }
}