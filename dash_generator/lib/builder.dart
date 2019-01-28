import 'package:build/build.dart';
import 'package:dash_generator/src/dash_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder blocProvider(BuilderOptions options) =>
    SharedPartBuilder([BlocProviderGenerator()], 'bloc_provider');
