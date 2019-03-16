import 'package:dash/dash.dart';

class MyBloc1 extends Bloc {
  @override
  dispose() {
    //dispose all streams
  }

  static Bloc instance() => MyBloc1();
}