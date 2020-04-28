import 'package:dash/dash.dart';

class BlocExample extends Bloc {
  String someValue = 'test';
  @override
  dispose() {
    //dispose all streams
    someValue = null;
  }

  static Bloc instance() => BlocExample();
}
