# Dash

![Logo](https://raw.githubusercontent.com/ViniciusSossela/dash/master/dash/img/logo_dash.png)

Dash is a simple but efficient library that helps provide BloCs without headaches.

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
  build_runner: ^2.0.3
  dash_generator: ^latest_version
```


## Usage

1 - Create a provider class that will gather BlocProvider annotation:

**IMPORTANT: Do not forget to add: part 'provider.g.dart';.**

```dart
import 'package:dash/dash.dart';

part 'provider.g.dart';

@BlocProvider.register(MySampleBloc)
@BlocProvider.register(MyOtherBloc)
abstract class Provider {}

```


2 - Extend BLoCs from `Bloc`. It will allow you to override `dispose` method.

**IMPORTANT: All blocs must have an `instance()` function that returns the instance of the bloc as below.**


```dart
class MySampleBloc extends Bloc {

  @override
  dispose() {
    //close all streams
  }

  static Bloc instance() => MySampleBloc();
  
}

class MyOtherBloc extends Bloc {

  @override
  dispose() {
    //close all streams
  }

  static Bloc instance() => MyOtherBloc();
}
```


3 - Run build_runner, it will generate the `provider.g.dart` class that you added as part on your provider class.

On project directory run in terminal: 

`pub run build_runner build`

For flutter:

`flutter packages pub run build_runner build`


**Note:** If you encounter a conflict error, please add the --delete-conflicting-outputs argument to your command:

`flutter packages pub run build_runner build --delete-conflicting-outputs`


4 - Finally you can get your BLoC instance from anywhere, for example:

```dart
  @override
  Widget build(BuildContext context) {
    final _bloc = $Provider.of<MyOtherBloc>();

    return Container();
  }

  @override
  void dispose() {
    $Provider.dispose<MyOtherBloc>();
    super.dispose();
  }
```

## Changelog

Please see the [Changelog](https://github.com/ViniciusSossela/dash/blob/master/dash/CHANGELOG.md) page to know what's recently changed.