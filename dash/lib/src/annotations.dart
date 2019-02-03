class BlocProvider {
  final Type type;
  final List<Type> keepBloc;

  const BlocProvider.factory(
    this.type, {
    this.keepBloc,
  }) : assert(type != null);
}
