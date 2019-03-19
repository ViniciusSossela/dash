// import 'package:flutter_test/flutter_test.dart';

// import 'package:bloc_provider/bloc_provider.dart';

import 'package:dash/dash.dart';
import 'package:test/test.dart';

void main() {
  test('cache should be the same', () {
    var cache1 = BlocCache();
    var cache2 = BlocCache();
    expect(cache1, cache2);
  });

  test('BlocSample should not be null', () {
    BlocSample blocSample = BlocCache.getBlocInstance(
        'BlocSample', () => BlocSample.instance());

    expect(blocSample != null, true);
  });

  test('BlocSample should be the same', () {
    BlocSample blocSample = BlocCache.getBlocInstance(
        'BlocSample', () => BlocSample.instance());

    BlocSample blocSample2 = BlocCache.getBlocInstance(
        'BlocSample', () => BlocSample.instance());

    expect(blocSample, blocSample2);
  });

  test('BlocSample should be disposed', () {
    BlocSample blocSample = BlocCache.getBlocInstance(
        'BlocSample', () => BlocSample.instance());

    BlocCache.dispose('BlocSample');

    expect(blocSample.test, null);
  });
}

class BlocSample extends Bloc {
  String test = 'BlocSample';

  static BlocSample instance() => BlocSample();

  @override
  dispose() {
    test = null;
  }
}
