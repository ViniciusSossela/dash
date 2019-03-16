class BlocProvider {
  final Type type;
  final List<Type> keepBloc;

  const BlocProvider.register(
    this.type, {
    this.keepBloc,
  }) : assert(type != null);
}