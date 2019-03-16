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

  test('BlocSampleDisposable should not be null', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        'BlocSampleDisposable', () => BlocSampleDisposable.instance());

    expect(blocSampleDisposable != null, true);
  });

  test('BlocSampleDisposable should be the same', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        'BlocSampleDisposable', () => BlocSampleDisposable.instance());

    BlocSampleDisposable blocSampleDisposable2 = BlocCache.getBlocInstance(
        'BlocSampleDisposable', () => BlocSampleDisposable.instance());

    expect(blocSampleDisposable, blocSampleDisposable2);
  });

  test('BlocSampleDisposable should be disposed', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        'BlocSampleDisposable', () => BlocSampleDisposable.instance());

    BlocCache.dispose('BlocSampleDisposable');

    expect(blocSampleDisposable.test, null);
  });
}

class BlocSampleDisposable extends Bloc {
  String test = 'BlocSampleDisposable';

  static BlocSampleDisposable instance() => BlocSampleDisposable();

  @override
  dispose() {
    test = null;
  }
}
