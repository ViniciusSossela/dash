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

/// Responsible to generate the Provider class that will expose de of() and dispose() method for blocs.
class BlocProviderGenerator extends Generator {
  const BlocProviderGenerator();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    // An bloc provider is an abstract class where all abstract methods are
    // annotated with BlocProvider.register.
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
      ..methods.addAll(
          [_getOfMethod(blocProvider), _getDisposeMethod(blocProvider)]));
  }

  Method _getOfMethod(ClassElement blocProvider) {
    var paramters = ListBuilder<Parameter>();

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
        'case $type: { return BlocCache.getBlocInstance("${type.name}", () => $type.instance()); }');
  }

  Method _getDisposeMethod(ClassElement blocProvider) {
    var paramters = ListBuilder<Parameter>();

    return Method.returnsVoid((method) => method
      ..name = 'dispose<T extends Bloc>'
      ..static = true
      ..optionalParameters = paramters
      ..body = Block((bb) => bb
        ..statements.add(Code('switch (T) {'))
        ..statements.addAll(_generateSwitchCasesOfDispose(blocProvider))
        ..statements.add(Code('}'))));
  }

  List<Code> _generateSwitchCasesOfDispose(ClassElement blocProvider) {
    return _blocProviderTypeChecker
        .annotationsOfExact(blocProvider)
        .map((a) => _generateCasesOfDispose(
            AnnotatedElement(ConstantReader(a), blocProvider)))
        .toList();
  }

  Code _generateCasesOfDispose(AnnotatedElement annotatedMethod) {
    final ConstantReader annotation = annotatedMethod.annotation;
    final DartObject registerObject = annotation.objectValue;

    final DartType type = registerObject.getField('type').toTypeValue();

    return Code('case $type: { BlocCache.dispose("${type.name}"); break;}');
  }
}
