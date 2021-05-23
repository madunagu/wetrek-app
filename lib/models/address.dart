import 'package:json_annotation/json_annotation.dart';


part 'address.g.dart';

@JsonSerializable()
class Address {
      Address();

  @JsonKey(name: 'address_components') List<dynamic> addressComponents;
  @JsonKey(name: 'formatted_address') String formattedAddress;
  Geometry geometry;
  @JsonKey(name: 'place_id') String placeId;
  @JsonKey(name: 'plus_code') PlusCode plusCode;
  List<dynamic> types;

  factory Address.fromJson(Map<String,dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geometry {
      Geometry();

  Location location;
  @JsonKey(name: 'location_type') String locationType;
  Viewport viewport;

  factory Geometry.fromJson(Map<String,dynamic> json) => _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Location {
      Location();

  double lat;
  double lng;

  factory Location.fromJson(Map<String,dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Viewport {
      Viewport();

  Northeast northeast;
  Southwest southwest;

  factory Viewport.fromJson(Map<String,dynamic> json) => _$ViewportFromJson(json);
  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}

@JsonSerializable()
class Northeast {
      Northeast();

  double lat;
  double lng;

  factory Northeast.fromJson(Map<String,dynamic> json) => _$NortheastFromJson(json);
  Map<String, dynamic> toJson() => _$NortheastToJson(this);
}

@JsonSerializable()
class Southwest {
      Southwest();

  double lat;
  double lng;

  factory Southwest.fromJson(Map<String,dynamic> json) => _$SouthwestFromJson(json);
  Map<String, dynamic> toJson() => _$SouthwestToJson(this);
}

@JsonSerializable()
class PlusCode {
      PlusCode();

  @JsonKey(name: 'compound_code') String compoundCode;
  @JsonKey(name: 'global_code') String globalCode;

  factory PlusCode.fromJson(Map<String,dynamic> json) => _$PlusCodeFromJson(json);
  Map<String, dynamic> toJson() => _$PlusCodeToJson(this);
}
