class Parameters {
  const Parameters({
    this.q = '',
    this.length = 0,
    this.page = 0,
    this.where = const {},
  });
  final String q;
  final int length;
  final int page;
  final Map<String, String> where;
}
