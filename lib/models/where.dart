class Where {
  final String column;
  final String val;
  final String mediator;
  Where({required this.column, required this.val, this.mediator = '='});

  Map<String, dynamic> toJson() => {
        'column': column,
        'val': val,
        'mediator': mediator,
      };
}
