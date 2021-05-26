import 'package:flutter/foundation.dart';


@immutable
class PlusCode {

  const PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  final String compoundCode;
  final String globalCode;

  factory PlusCode.fromJson(Map<String,dynamic> json) => PlusCode(
    compoundCode: json['compound_code'] as String,
    globalCode: json['global_code'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'compound_code': compoundCode,
    'global_code': globalCode
  };

  PlusCode clone() => PlusCode(
    compoundCode: compoundCode,
    globalCode: globalCode
  );


  PlusCode copyWith({
    String? compoundCode,
    String? globalCode
  }) => PlusCode(
    compoundCode: compoundCode ?? this.compoundCode,
    globalCode: globalCode ?? this.globalCode,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PlusCode && compoundCode == other.compoundCode && globalCode == other.globalCode;

  @override
  int get hashCode => compoundCode.hashCode ^ globalCode.hashCode;
}
