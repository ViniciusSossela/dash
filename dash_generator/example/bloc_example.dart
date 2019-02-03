import 'package:dash/dash.dart';

class BlocExample extends Bloc {
  static final String key = 'BlocExample';

  @override
  bool disposable() {
    return true;
  }

  @override
  dispose() {
    //dispose all streams
  }

  static Bloc instance() {
    return BlocExample();
  }
}
