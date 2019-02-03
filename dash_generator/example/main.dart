import 'bloc_example.dart';
import 'provider.dart';

class Main{
  void anyMethod(){
    final bloc = $Provider.of<BlocExample>();
  }
}