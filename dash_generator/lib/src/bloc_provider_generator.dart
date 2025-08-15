import 'dart:async';

import 'package:analyzer/dart/element/element2.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dash/dash.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _blocProviderTypeChecker =
    TypeChecker.typeNamed(BlocProvider);

bool _isBlocProviderClass(ClassElement2 classBlocProvider) =>
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

    if (blocProviders.isEmpty) return '';

    final file = Library((lb) => lb
      ..body.addAll(blocProviders
          .map((i) => _generateBlocProviderClass(i, library, buildStep))));

    final emitter = DartEmitter();
    return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)
        .format('${file.accept(emitter)}');
  }

  Class _generateBlocProviderClass(
      ClassElement2 blocProvider, LibraryReader library, BuildStep buildStep) {
    return Class((cb) => cb
      ..name = '\$${blocProvider.displayName}'
      ..extend = refer(blocProvider.displayName)
      ..methods.addAll(
          [_getOfMethod(blocProvider), _getDisposeMethod(blocProvider)]));
  }

  Method _getOfMethod(ClassElement2 blocProvider) {
    var paramters = ListBuilder<Parameter>();

    return Method((method) => method
      ..name = 'of<T extends Bloc>'
      ..returns = Reference('T')
      ..optionalParameters = paramters
      ..annotations.add(refer('override'))
      ..body = Block((bb) => bb
        ..statements.add(Code('switch (T) {'))
        ..statements.addAll(_generateSwitchCases(blocProvider))
        ..statements.add(Code('}'))
        ..statements.add(Code('throw Exception(\'Bloc not found\');'))));
  }

  List<Code> _generateSwitchCases(ClassElement2 blocProvider) {
    return _blocProviderTypeChecker
        .annotationsOfExact(blocProvider)
        .map((a) =>
            _generateCases(AnnotatedElement(ConstantReader(a), blocProvider)))
        .toList();
  }

  Code _generateCases(AnnotatedElement annotatedMethod) {
    final annotation = annotatedMethod.annotation;
    final registerObject = annotation.objectValue;

    final type = registerObject.getField('type')?.toTypeValue();

    return Code(
        'case ${type?.getDisplayString()}: { return BlocCache.getBlocInstance(\'${type?.getDisplayString()}\', () => ${type?.getDisplayString()}.instance()) as T; }');
  }

  Method _getDisposeMethod(ClassElement2 blocProvider) {
    var paramters = ListBuilder<Parameter>();

    return Method.returnsVoid((method) => method
      ..name = 'dispose<T extends Bloc>'
      ..optionalParameters = paramters
      ..annotations.add(refer('override'))
      ..body = Block((bb) => bb
        ..statements.add(Code('switch (T) {'))
        ..statements.addAll(_generateSwitchCasesOfDispose(blocProvider))
        ..statements.add(Code('}'))));
  }

  List<Code> _generateSwitchCasesOfDispose(ClassElement2 blocProvider) {
    return _blocProviderTypeChecker
        .annotationsOfExact(blocProvider)
        .map((a) => _generateCasesOfDispose(
            AnnotatedElement(ConstantReader(a), blocProvider)))
        .toList();
  }

  Code _generateCasesOfDispose(AnnotatedElement annotatedMethod) {
    final annotation = annotatedMethod.annotation;
    final registerObject = annotation.objectValue;

    final type = registerObject.getField('type')?.toTypeValue();

    return Code(
        'case ${type?.getDisplayString()}: { BlocCache.dispose(\'${type?.getDisplayString()}\'); break;}');
  }
}
