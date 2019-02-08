import 'package:dash/dash.dart';

class Main {
  void anyMethod() {
    BlocSample _bloc = Provider.of<BlocSample>();
  }
}

class Provider {
  static T of<T extends Bloc>([List<String> keepBlocs = const []]) {
    switch (T) {
      case BlocSample:
        {
          return BlocCache.getBlocInstance(
              BlocSample.key, () => BlocSample.instance());
        }
    }
    return null;
  }
}

class BlocSample extends Bloc {
  String test = 'BlocSample';
  static final String key = 'BlocSample';

  static BlocSample instance() => BlocSample();

  @override
  bool disposable() {
    return false;
  }

  @override
  dispose() {
    //close streams
  }
}
