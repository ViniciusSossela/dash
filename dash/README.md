# Dash

![Logo](https://raw.githubusercontent.com/ViniciusSossela/dash/master/img/lib_logo.png)
Dash is a simple but efficient library that provides BloCs class without headaches.

**IMPORTANT: Dart2 is required to use this package.**


## Installation

- Add `dash` to your pubspec.yaml under the dependencies section:

```
dependencies:
  dash: ^latest_version
```

- Add `build_runner` and `dash_generator` to your pubspec.yaml under the dev_dependencies section:

```
dev_dependencies:
  build_runner: ^1.1.3
  dash_generator: ^latest_version
```


## Usage

1 - Create a provider class that is going to gathering all BlocProvider annotation:

**IMPORTANT: Do not forget to add: part 'provider.g.dart';.**

```dart
import 'package:dash/dash.dart';

part 'provider.g.dart';

@BlocProvider.factory(MySampleBloc)
@BlocProvider.factory(MyOtherBloc)
abstract class Provider {}

```


2 - Extends all your bloc class from `Bloc`. It will allow you to override `disposable` and `dispose` method.

**IMPORTANT: In order to cache bloc class it must has an unique ID that is represented by a static string property named as `key`. Also an `instance()` function that returns the instance of the bloc class as show bellow is necessary.**


```dart
class MySampleBloc extends Bloc {
  static final String key = 'MySampleBloc-uid';

  @override
  bool disposable() {
    return true;
  }

  @override
  dispose() {
    //close all streams
  }

  static Bloc instance() {
    return MyBloc2();
  }
}

class MyOtherBloc extends Bloc {
  static final String key = 'MyOtherBloc-uid';

  @override
  bool disposable() {
    return true;
  }

  @override
  dispose() {
    //close all streams
  }

  static Bloc instance() {
    return MyOtherBloc();
  }
}
```


3 - Run build_runner, it will generate the `provider.g.dart` class that you added as part on your provider class.

On project directory run on terminal: 

`pub run build_runner build`

For flutter is:

`flutter packages pub run build_runner build`


**Note:** If you encounter a conflict error, please add the --delete-conflicting-outputs argument to your command:

`flutter packages pub run build_runner build --delete-conflicting-outputs`


4 - Finally you can get your bloc class instance from wherever you want, example:

```dart
@override
  Widget build(BuildContext context) {
    final _bloc = $Provider.of<MyOtherBloc>();

    return Container();
  }
```

## Changelog

Please see the [Changelog](https://github.com/ViniciusSossela/dash/blob/master/dash/CHANGELOG.md) page to know what's recently changed.