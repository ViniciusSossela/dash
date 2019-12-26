import 'bloc_example.dart';
import 'provider.dart';

class Main {
  BlocExample provideBlocExample() => $Provider.of<BlocExample>();

  disposeBlocExample() => $Provider.dispose<BlocExample>();
}
