import 'package:dash/dash.dart';

import 'provider.dart';

class Main {
  init() {
    BlocSample _bloc = Provider.of<BlocSample>();
    _bloc.load();
  }

  dispose() {
    Provider.dispose<BlocSample>();
  }
}

class BlocSample extends Bloc {
  String test = 'BlocSample';

  static BlocSample instance() => BlocSample();

  load() {
    //load initial data
  }

  @override
  dispose() {
    //close streams
  }
}
