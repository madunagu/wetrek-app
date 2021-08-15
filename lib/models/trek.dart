import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'address.dart';
import 'messagable.dart';
import 'user.dart';
import 'picture.dart';
import 'direction.dart';
import 'location.dart';

@immutable
class Trek extends Messagable {
  const Trek({
    required this.id,
    required this.name,
    required this.startAddress,
    required this.endAddress,
    required this.startAddressId,
    required this.endAddressId,
    this.repeat,
    this.users,
    required this.picture,
    required this.direction,
    this.locations,
    required this.startingAt,
    required this.userId,
    required this.description,
    required this.usersCount,
    this.pictures,
    required this.duration,
    this.endingAt,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: id, name: name, picture: picture, isGroup: true);

  final int id;
  final String name;
  final Address startAddress;
  final Address endAddress;
  final String startAddressId;
  final String endAddressId;
  final String? repeat;
  final List<User>? users;
  final Picture picture;
  final Direction direction;
  final List<Location>? locations;
  final DateTime startingAt;
  final String userId;
  final String description;
  final String usersCount;
  final List<Picture>? pictures;
  final String duration;
  final DateTime? endingAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Trek.fromJson(Map<String, dynamic> json) => Trek(
      id: json['id'] as int,
      name: json['name'] as String,
      startAddress: Address.fromJson(json['start_address']),
      endAddress: Address.fromJson(json['end_address']),
      startAddressId: json['start_address_id'] as String,
      endAddressId: json['end_address_id'] as String,
      repeat: json['repeat'] != null ? json['repeat'] as String : null,
      users: json['users'] != null
          ? (json['users'] as List? ?? []).map((e) => User.fromJson(e)).toList()
          : null,
      picture: Picture.fromJson(json['picture']),
      direction: Direction.fromJson(jsonDecode(json['direction'])),
      locations: json['locations'] != null
          ? (json['locations'] as List? ?? [])
              .map((e) => Location.fromJson(e))
              .toList()
          : null,
      startingAt: DateTime.parse(json['starting_at'] as String),
      userId: json['user_id'] as String,
      description: json['description'] as String,
      usersCount: json['users_count'] as String,
      pictures: json['pictures'] != null
          ? (json['pictures'] as List? ?? [])
              .map((e) => Picture.fromJson(e))
              .toList()
          : null,
      duration: json['duration'] as String,
      endingAt: json['ending_at'] != null
          ? DateTime.parse(json['ending_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'start_address': startAddress,
        'end_address': endAddress,
        'start_address_id': startAddressId,
        'end_address_id': endAddressId,
        'repeat': repeat,
        'users': users?.map((e) => e.toString()).toList(),
        'picture': picture,
        'direction': direction,
        'locations': locations?.map((e) => e.toString()).toList(),
        'starting_at': startingAt.toIso8601String(),
        'user_id': userId,
        'description': description,
        'users_count': usersCount,
        'pictures': pictures?.map((e) => e.toString()).toList(),
        'duration': duration,
        'ending_at': endingAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String()
      };

  Trek clone() => Trek(
      id: id,
      name: name,
      startAddress: startAddress,
      endAddress: endAddress,
      startAddressId: startAddressId,
      endAddressId: endAddressId,
      repeat: repeat,
      users: users?.toList(),
      picture: picture,
      direction: direction,
      locations: locations?.toList(),
      startingAt: startingAt,
      userId: userId,
      description: description,
      usersCount: usersCount,
      pictures: pictures?.toList(),
      duration: duration,
      endingAt: endingAt,
      createdAt: createdAt,
      updatedAt: updatedAt);

  Trek copyWith(
          {int? id,
          String? name,
          Address? startAddress,
          Address? endAddress,
          String? startAddressId,
          String? endAddressId,
          String? repeat,
          List<User>? users,
          Picture? picture,
          Direction? direction,
          List<Location>? locations,
          DateTime? startingAt,
          String? userId,
          String? description,
          String? usersCount,
          List<Picture>? pictures,
          String? duration,
          DateTime? endingAt,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Trek(
        id: id ?? this.id,
        name: name ?? this.name,
        startAddress: startAddress ?? this.startAddress,
        endAddress: endAddress ?? this.endAddress,
        startAddressId: startAddressId ?? this.startAddressId,
        endAddressId: endAddressId ?? this.endAddressId,
        repeat: repeat ?? this.repeat,
        users: users ?? this.users,
        picture: picture ?? this.picture,
        direction: direction ?? this.direction,
        locations: locations ?? this.locations,
        startingAt: startingAt ?? this.startingAt,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        usersCount: usersCount ?? this.usersCount,
        pictures: pictures ?? this.pictures,
        duration: duration ?? this.duration,
        endingAt: endingAt ?? this.endingAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trek &&
          id == other.id &&
          name == other.name &&
          startAddress == other.startAddress &&
          endAddress == other.endAddress &&
          startAddressId == other.startAddressId &&
          endAddressId == other.endAddressId &&
          repeat == other.repeat &&
          users == other.users &&
          picture == other.picture &&
          direction == other.direction &&
          locations == other.locations &&
          startingAt == other.startingAt &&
          userId == other.userId &&
          description == other.description &&
          usersCount == other.usersCount &&
          pictures == other.pictures &&
          duration == other.duration &&
          endingAt == other.endingAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      startAddress.hashCode ^
      endAddress.hashCode ^
      startAddressId.hashCode ^
      endAddressId.hashCode ^
      repeat.hashCode ^
      users.hashCode ^
      picture.hashCode ^
      direction.hashCode ^
      locations.hashCode ^
      startingAt.hashCode ^
      userId.hashCode ^
      description.hashCode ^
      usersCount.hashCode ^
      pictures.hashCode ^
      duration.hashCode ^
      endingAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
