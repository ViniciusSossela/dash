import 'dart:collection';

class BlocProvider {
  final Type type;
  final List<Type> keepBloc;

  const BlocProvider.factory(
    this.type, {
    this.keepBloc,
  }) : assert(type != null);
}

abstract class Bloc {
  dispose();
  bool disposable();
}

class BlocProviderCache {
  HashMap<String, Bloc> blocs = HashMap<String, Bloc>();

  static final BlocProviderCache _singleton = BlocProviderCache._internal();

  factory BlocProviderCache() {
    return _singleton;
  }

  BlocProviderCache._internal();

  static Bloc getBlocInstance(
      List<String> keepBlocs, String blocKey, Function instance) {
    var bloc = BlocProviderCache._singleton.blocs[blocKey];
    List<String> listKeepBlocs;
    if (!keepBlocs.contains(blocKey))
      listKeepBlocs = List.from(keepBlocs)..add(blocKey);

    if (bloc != null) {
      _disposeAllAndKeep(listKeepBlocs);
      return bloc;
    }

    bloc = instance();
    BlocProviderCache._singleton.blocs[blocKey] = bloc;
    _disposeAllAndKeep(listKeepBlocs);

    return bloc;
  }

  static _disposeAllAndKeep(List<String> blocKeys) async {
    BlocProviderCache._singleton.blocs.forEach((key, bloc) {
      if (bloc.disposable() && !blocKeys.contains(key)) bloc.dispose();
    });

    BlocProviderCache._singleton.blocs.removeWhere(
        (key, bloc) => bloc.disposable() && !blocKeys.contains(key));
  }
}
