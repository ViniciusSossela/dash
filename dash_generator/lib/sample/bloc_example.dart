import 'package:dash/dash.dart';

class BlocExample extends Bloc {
  String someValue = 'test';
  @override
  void dispose() {
    //dispose all streams
    someValue = '';
  }

  static Bloc instance() => BlocExample();
}
