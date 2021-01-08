import 'package:dash/dash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cache should be the same', () {
    var cache1 = BlocCache();
    var cache2 = BlocCache();
    expect(cache1, cache2);
  });

  test('BlocSample should not be null', () {
    final blocSample =
        BlocCache.getBlocInstance('BlocSample', () => BlocSample.instance());
    expect(blocSample is BlocSample, true);
  });

  test('BlocSample should be the same', () {
    final blocSample =
        BlocCache.getBlocInstance('BlocSample', () => BlocSample.instance());

    final blocSample2 =
        BlocCache.getBlocInstance('BlocSample', () => BlocSample.instance());

    expect(blocSample, blocSample2);
  });

  test('BlocSample should be disposed', () {
    final blocSample =
        BlocCache.getBlocInstance('BlocSample', () => BlocSample.instance())
            as BlocSample;

    BlocCache.dispose('BlocSample');

    expect(blocSample.test, '');
  });
}

class BlocSample extends Bloc {
  String test = 'BlocSample';

  static BlocSample instance() => BlocSample();

  @override
  void dispose() {
    test = '';
  }
}
