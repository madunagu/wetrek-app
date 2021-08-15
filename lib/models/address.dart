import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';
import 'Match.dart';
import 'Match.dart';
import 'Match.dart';

@immutable
class Address extends Model {

  const Address({
    required this.description,
    required this.placeId,
    required this.reference,
    this.matchedSubstrings,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  final String description;
  final String placeId;
  final String reference;
  final List<Match>? matchedSubstrings;
  final StructuredFormatting? structuredFormatting;
  final List<Match>? terms;
  final List<String>? types;

  factory Address.fromJson(Map<String,dynamic> json) => Address(
    description: json['description'] as String,
    placeId: json['place_id'] as String,
    reference: json['reference'] as String,
    matchedSubstrings: json['matched_substrings'] != null ? (json['matched_substrings'] as List? ?? []).map((e) => e as Match).toList() : null,
    structuredFormatting: json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting'] as Map<String, dynamic>) : null,
    terms: json['terms'] != null ? (json['terms'] as List? ?? []).map((e) => e as Match).toList() : null,
//    types: json['types'] != null ? (json['types'] as List? ?? []).map((e) => e as String).toList() : null
  );
  
  Map<String, dynamic> toJson() => {
    'description': description,
    'place_id': placeId,
    'reference': reference,
    'matched_substrings': matchedSubstrings?.map((e) => e.toString()).toList(),
    'structured_formatting': structuredFormatting?.toJson(),
    'terms': terms?.map((e) => e.toString()).toList(),
    'types': types?.map((e) => e.toString()).toList()
  };

  Address clone() => Address(
    description: description,
    placeId: placeId,
    reference: reference,
    matchedSubstrings: matchedSubstrings?.toList(),
    structuredFormatting: structuredFormatting?.clone(),
    terms: terms?.toList(),
    types: types?.toList()
  );


  Address copyWith({
    String? description,
    String? placeId,
    String? reference,
    List<Match>? matchedSubstrings,
    StructuredFormatting? structuredFormatting,
    List<Match>? terms,
    List<String>? types
  }) => Address(
    description: description ?? this.description,
    placeId: placeId ?? this.placeId,
    reference: reference ?? this.reference,
    matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
    structuredFormatting: structuredFormatting ?? this.structuredFormatting,
    terms: terms ?? this.terms,
    types: types ?? this.types,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Address && description == other.description && placeId == other.placeId && reference == other.reference && matchedSubstrings == other.matchedSubstrings && structuredFormatting == other.structuredFormatting && terms == other.terms && types == other.types;

  @override
  int get hashCode => description.hashCode ^ placeId.hashCode ^ reference.hashCode ^ matchedSubstrings.hashCode ^ structuredFormatting.hashCode ^ terms.hashCode ^ types.hashCode;
}

@immutable
class StructuredFormatting {

  const StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  final String mainText;
  final List<Match> mainTextMatchedSubstrings;
  final String secondaryText;

  factory StructuredFormatting.fromJson(Map<String,dynamic> json) => StructuredFormatting(
    mainText: json['main_text'] as String,
    mainTextMatchedSubstrings: (json['main_text_matched_substrings'] as List? ?? []).map((e) => e as Match).toList(),
    secondaryText: json['secondary_text'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'main_text': mainText,
    'main_text_matched_substrings': mainTextMatchedSubstrings.map((e) => e.toString()).toList(),
    'secondary_text': secondaryText
  };

  StructuredFormatting clone() => StructuredFormatting(
    mainText: mainText,
    mainTextMatchedSubstrings: mainTextMatchedSubstrings.toList(),
    secondaryText: secondaryText
  );


  StructuredFormatting copyWith({
    String? mainText,
    List<Match>? mainTextMatchedSubstrings,
    String? secondaryText
  }) => StructuredFormatting(
    mainText: mainText ?? this.mainText,
    mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
    secondaryText: secondaryText ?? this.secondaryText,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is StructuredFormatting && mainText == other.mainText && mainTextMatchedSubstrings == other.mainTextMatchedSubstrings && secondaryText == other.secondaryText;

  @override
  int get hashCode => mainText.hashCode ^ mainTextMatchedSubstrings.hashCode ^ secondaryText.hashCode;
}
