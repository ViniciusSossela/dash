class BlocProvider {
  final Type type;
  final List<Type> keepBloc;

  /// Responsible to register bloc class that need to be provided.
  const BlocProvider.register(
    this.type, {
    this.keepBloc,
  }) : assert(type != null);
}