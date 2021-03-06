# Dash

![Logo](https://raw.githubusercontent.com/ViniciusSossela/dash/master/dash/img/logo_dash.png)

Dash is a simple but efficient library that provides and dispose BloCs class without headaches.

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

1 - Create a provider class that is going to gathering all BlocProvider annotation:

**IMPORTANT: Do not forget to add: part 'provider.g.dart';.**

```dart
import 'package:dash/dash.dart';

part 'provider.g.dart';

@BlocProvider.register(MySampleBloc)
@BlocProvider.register(MyOtherBloc)
abstract class Provider {}

```


2 - Extends all your bloc class from `Bloc`. It will allow you to override `dispose` method.

**IMPORTANT: All bloc class must has an `instance()` function that returns the instance of the bloc class as bellow.**


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

  @override
  void dispose() {
    $Provider.dispose<MyOtherBloc>();
    super.dispose();
  }
```

## Changelog

Please see the [Changelog](https://github.com/ViniciusSossela/dash/blob/master/dash/CHANGELOG.md) page to know what's recently changed.