import 'package:flutter/foundation.dart';


@immutable
class User {

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  final int? id;
  final String name;
  final String email;
  final String avatar;

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'] != null ? json['id'] as int : null,
    name: json['name'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar': avatar
  };

  User clone() => User(
    id: id,
    name: name,
    email: email,
    avatar: avatar
  );


  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is User && id == other.id && name == other.name && email == other.email && avatar == other.avatar;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ avatar.hashCode;
}
