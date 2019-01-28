import 'package:bloc_provider_generator/src/bloc_provider_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder blocProvider(BuilderOptions options) =>
    SharedPartBuilder([BlocProviderGenerator()], 'bloc_provider');
