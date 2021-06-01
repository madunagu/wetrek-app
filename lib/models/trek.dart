import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';
import 'address.dart';
import 'user.dart';
import 'location.dart';

@immutable
class Trek extends Model {

  const Trek({
    required this.startAddress,
    required this.endAddress,
    this.users,
    required this.name,
    required this.locations,
    required this.startingAt,
    this.endingAt,
    required this.createdAt,
  });

  final Address startAddress;
  final Address endAddress;
  final List<User>? users;
  final String name;
  final List<Location> locations;
  final DateTime startingAt;
  final DateTime? endingAt;
  final DateTime createdAt;

  factory Trek.fromJson(Map<String,dynamic> json) => Trek(
    startAddress: json['start_address'] as Address,
    endAddress: json['end_address'] as Address,
    users: json['users'] != null ? (json['users'] as List? ?? []).map((e) => e as User).toList() : null,
    name: json['name'] as String,
    locations: (json['locations'] as List? ?? []).map((e) => e as Location).toList(),
    startingAt: DateTime.parse(json['starting_at'] as String),
    endingAt: json['ending_at'] != null ? DateTime.parse(json['ending_at'] as String) : null,
    createdAt: DateTime.parse(json['created_at'] as String)
  );
  
  Map<String, dynamic> toJson() => {
    'start_address': startAddress,
    'end_address': endAddress,
    'users': users?.map((e) => e.toString()).toList(),
    'name': name,
    'locations': locations.map((e) => e.toString()).toList(),
    'starting_at': startingAt.toIso8601String(),
    'ending_at': endingAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String()
  };

  Trek clone() => Trek(
    startAddress: startAddress,
    endAddress: endAddress,
    users: users?.toList(),
    name: name,
    locations: locations.toList(),
    startingAt: startingAt,
    endingAt: endingAt,
    createdAt: createdAt
  );


  Trek copyWith({
    Address? startAddress,
    Address? endAddress,
    List<User>? users,
    String? name,
    List<Location>? locations,
    DateTime? startingAt,
    DateTime? endingAt,
    DateTime? createdAt
  }) => Trek(
    startAddress: startAddress ?? this.startAddress,
    endAddress: endAddress ?? this.endAddress,
    users: users ?? this.users,
    name: name ?? this.name,
    locations: locations ?? this.locations,
    startingAt: startingAt ?? this.startingAt,
    endingAt: endingAt ?? this.endingAt,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Trek && startAddress == other.startAddress && endAddress == other.endAddress && users == other.users && name == other.name && locations == other.locations && startingAt == other.startingAt && endingAt == other.endingAt && createdAt == other.createdAt;

  @override
  int get hashCode => startAddress.hashCode ^ endAddress.hashCode ^ users.hashCode ^ name.hashCode ^ locations.hashCode ^ startingAt.hashCode ^ endingAt.hashCode ^ createdAt.hashCode;
}
