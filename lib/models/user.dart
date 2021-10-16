import 'package:flutter/foundation.dart';
import 'package:wetrek/models/messagable.dart';
import 'package:wetrek/models/settings.dart';
import 'picture.dart';
import 'location.dart';

@immutable
class User extends Messagable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.phone,
    required this.picture,
    this.following,
    this.followers,
    required this.locations,
    required this.settings,
  }) : super(id: id, name: name, picture: picture);

  final int id;
  final String name;
  final String email;
  final String? token;
  final String? phone;
  final Picture picture;
  final List<int>? following;
  final List<int>? followers;
  final List<Location> locations;
  final Settings settings;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] != null ? json['token'] as String : null,
      phone: json['phone'] != null ? json['phone'] as String : null,
      picture: Picture.fromJson(json['picture']),
      settings: Settings.fromJson(json['settings']),
      following: json['following'] != null
          ? (json['following'] as List? ?? []).map((e) => e as int).toList()
          : null,
      followers: json['followers'] != null
          ? (json['followers'] as List? ?? []).map((e) => e as int).toList()
          : null,
      locations: (json['locations'] as List? ?? [])
          .map((e) =>Location.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'token': token,
        'phone': phone,
        'picture': picture,
        'following': following?.map((e) => e.toString()).toList(),
        'followers': followers?.map((e) => e.toString()).toList(),
        'locations': locations.map((e) => e.toString()).toList()
      };

  User clone() => User(
      id: id,
      name: name,
      email: email,
      token: token,
      phone: phone,
      picture: picture,
      settings: settings,
      following: following?.toList(),
      followers: followers?.toList(),
      locations: locations.toList());

  User copyWith(
          {int? id,
          String? name,
          String? email,
          String? token,
          String? phone,
          Picture? picture,
          Settings? settings,
          List<int>? following,
          List<int>? followers,
          List<Location>? locations}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        token: token ?? this.token,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
        settings: settings ?? this.settings,
        following: following ?? this.following,
        followers: followers ?? this.followers,
        locations: locations ?? this.locations,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          token == other.token &&
          phone == other.phone &&
          picture == other.picture &&
          following == other.following &&
          followers == other.followers &&
          locations == other.locations;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      token.hashCode ^
      phone.hashCode ^
      picture.hashCode ^
      following.hashCode ^
      followers.hashCode ^
      locations.hashCode;
}
