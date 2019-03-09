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
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    expect(blocSampleDisposable != null, true);
  });

  test('BlocSampleDisposable should be the same', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    BlocSampleDisposable blocSampleDisposable2 = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    expect(blocSampleDisposable, blocSampleDisposable2);
  });

  test('BlocSampleDisposable should not be disposed', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    BlocSampleDisposable blocSampleDisposable2 = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    expect(blocSampleDisposable.test, 'BlocSampleDisposable');
    expect(blocSampleDisposable2.test, 'BlocSampleDisposable');
  });

  test('BlocSampleDisposable should be disposed', () {
    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    BlocSampleNotDisposable blocSampleNotDisposable = BlocCache.getBlocInstance(
        BlocSampleNotDisposable.key, () => BlocSampleNotDisposable.instance());

    BlocCache.dispose(BlocSampleDisposable.key);

    expect(blocSampleDisposable.test, '');
    expect(blocSampleNotDisposable.test, 'BlocSampleNotDisposable');
  });

  test('BlocSampleNotDisposable should not be disposed', () {
    BlocSampleNotDisposable blocSampleNotDisposable = BlocCache.getBlocInstance(
        BlocSampleNotDisposable.key, () => BlocSampleNotDisposable.instance());

    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    expect(blocSampleNotDisposable.test, 'BlocSampleNotDisposable');
    expect(blocSampleDisposable.test, 'BlocSampleDisposable');
  });

  test('KeepBloc should not be disposed', () {
    KeepBloc keepBloc =
        BlocCache.getBlocInstance(KeepBloc.key, () => KeepBloc.instance());

    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    expect(keepBloc.test, 'KeepBloc');
    expect(blocSampleDisposable.test, 'BlocSampleDisposable');
  });

  test('KeepBloc should be disposed', () {
    KeepBloc keepBloc =
        BlocCache.getBlocInstance(KeepBloc.key, () => KeepBloc.instance());

    BlocSampleDisposable blocSampleDisposable = BlocCache.getBlocInstance(
        BlocSampleDisposable.key, () => BlocSampleDisposable.instance());

    BlocCache.dispose(KeepBloc.key);

    expect(keepBloc.test, '');
    expect(blocSampleDisposable.test, 'BlocSampleDisposable');
  });
}

class BlocSampleDisposable extends Bloc {
  String test = 'BlocSampleDisposable';
  static final String key = 'BlocSampleDisposable';

  static BlocSampleDisposable instance() => BlocSampleDisposable();

  @override
  dispose() {
    test = '';
  }
}

class BlocSampleNotDisposable extends Bloc {
  String test = 'BlocSampleNotDisposable';
  static final String key = 'BlocSampleNotDisposable';

  static BlocSampleNotDisposable instance() => BlocSampleNotDisposable();

  @override
  dispose() {
    test = '';
  }
}

class KeepBloc extends Bloc {
  String test = 'KeepBloc';
  static final String key = 'KeepBloc';

  static KeepBloc instance() => KeepBloc();

  @override
  dispose() {
    test = '';
  }
}
