import 'package:dash_generator/sample/bloc_example.dart';
import 'package:dash_generator/sample/provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get bloc instance', () {
    final bloc = $Provider.of<BlocExample>();

    expect(bloc is BlocExample, true);
  });

  test('should bloc instance be the same', () {
    final bloc = $Provider.of<BlocExample>();
    final bloc1 = $Provider.of<BlocExample>();

    expect(bloc, bloc1);
  });

  test('should bloc instance not be the same', () {
    final bloc = $Provider.of<BlocExample>();
    $Provider.dispose<BlocExample>();
    final bloc1 = $Provider.of<BlocExample>();

    expect(false, bloc1 == bloc);
  });

  test('should bloc be disposed', () {
    final bloc = $Provider.of<BlocExample>();
    $Provider.dispose<BlocExample>();

    expect('', bloc.someValue);
  });
}
