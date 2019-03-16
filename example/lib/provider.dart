import 'package:dash/dash.dart';
import 'package:example/mybloc1.dart';
import 'package:example/mybloc2.dart';

part 'provider.g.dart';

@BlocProvider.register(MyBloc1)
@BlocProvider.register(MyBloc2)
abstract class Provider {}
