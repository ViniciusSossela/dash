import 'package:dash/dash.dart';

part 'provider.g.dart';

@BlocProvider.factory(MyBloc1)
@BlocProvider.factory(MyBloc2)
abstract class Provider {}

class MyBloc1 extends Bloc {
  static final String key = '';

  @override
  bool disposable() {
    // TODO: implement disposable
    return null;
  }

  @override
  dispose() {
    // TODO: implement dispose
    return null;
  }

  static Bloc instance() {
    // TODO: implement instance
    return null;
  }
}

class MyBloc2 extends Bloc {
  static final String key = '';

  @override
  bool disposable() {
    // TODO: implement disposable
    return null;
  }

  @override
  dispose() {
    // TODO: implement dispose
    return null;
  }

  static Bloc instance() {
    // TODO: implement instance
    return null;
  }
}
