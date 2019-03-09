import 'package:dash/dash.dart';

part 'provider.g.dart';

@BlocProvider.factory(MyBloc1)
@BlocProvider.factory(MyBloc2)
abstract class Provider {}

class MyBloc1 extends Bloc {
  static final String key = 'MyBloc1';

  @override
  dispose() {
    //dispose all streams
  }

  static Bloc instance() {
    return MyBloc1();
  }
}

class MyBloc2 extends Bloc {
  static final String key = 'MyBloc2';

  myFunction() {
    print('MyBloc2 myFunction called');
  }

  @override
  dispose() {
    //dispose all streams
  }

  static Bloc instance() {
    return MyBloc2();
  }
}
