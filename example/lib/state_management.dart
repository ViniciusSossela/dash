import 'package:dash/dash.dart';

import 'main.dart';

part 'state_management.g.dart';

@BlocProvider.register(MyHomeBloc)
abstract class Provider {
  T of<T extends Bloc>();
  void dispose<T extends Bloc>();
}
