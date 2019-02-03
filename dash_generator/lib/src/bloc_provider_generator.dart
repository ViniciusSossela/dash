import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dash/dash.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _blocProviderTypeChecker =
    const TypeChecker.fromRuntime(BlocProvider);

bool _isBlocProviderClass(ClassElement classBlocProvider) =>
    _blocProviderTypeChecker.hasAnnotationOfExact(classBlocProvider);

class BlocProviderGenerator extends Generator {
  const BlocProviderGenerator();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final blocProviders = library.classes
        .where((c) => c.isAbstract && _isBlocProviderClass(c))
        .toList();

    if (blocProviders.isEmpty) {
      return null;
    }

    final file = Library((lb) => lb
      ..body.addAll(blocProviders
          .map((i) => _generateBlocProviderClass(i, library, buildStep))));

    final DartEmitter emitter = DartEmitter(Allocator());
    return DartFormatter().format('${file.accept(emitter)}');
  }

  Class _generateBlocProviderClass(
      ClassElement blocProvider, LibraryReader library, BuildStep buildStep) {
    return Class((cb) => cb
      ..name = '\$${blocProvider.name}'
      ..extend = refer(blocProvider.name)
      ..methods.add(_getOfMethod(blocProvider)));
  }

  Method _getOfMethod(ClassElement blocProvider) {
    var paramters = ListBuilder<Parameter>();

    paramters.add(Parameter((param) => param
      ..name = 'keepBlocs'
      ..type = Reference('List<String>')
      ..defaultTo = Code('const []')));

    return Method((method) => method
      ..name = 'of<T extends Bloc>'
      ..static = true
      ..returns = Reference('T')
      ..optionalParameters = paramters
      ..body = Block((bb) => bb
        ..statements.add(Code('switch (T) {'))
        ..statements.addAll(_generateSwitchCases(blocProvider))
        ..statements.add(Code('}'))
        ..statements.add(Code('return null;'))));
  }

  List<Code> _generateSwitchCases(ClassElement blocProvider) {
    return _blocProviderTypeChecker
        .annotationsOfExact(blocProvider)
        .map((a) =>
            _generateCases(AnnotatedElement(ConstantReader(a), blocProvider)))
        .toList();
  }

  Code _generateCases(AnnotatedElement annotatedMethod) {
    final ConstantReader annotation = annotatedMethod.annotation;
    final DartObject registerObject = annotation.objectValue;

    final DartType type = registerObject.getField('type').toTypeValue();

    return Code(
        'case $type: { return BlocCache.getBlocInstance(keepBlocs, $type.key, () => $type.instance()); }');
  }
}
