import 'package:dash/dash.dart';

class MyBloc2 extends Bloc {
  loadInitialData() {
    print('loadInitialData from MyBloc2 called');
  }

  @override
  dispose() {
    //dispose all streams
  }

  static Bloc instance() => MyBloc2();
}
