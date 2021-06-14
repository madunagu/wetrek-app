import 'package:flutter/foundation.dart';


@immutable
class User {

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.token,
  });

  final int id;
  final String name;
  final String email;
  final String avatar;
  final String? token;

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    token: json['token'] != null ? json['token'] as String : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar': avatar,
    'token': token
  };

  User clone() => User(
    id: id,
    name: name,
    email: email,
    avatar: avatar,
    token: token
  );


  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    String? token
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    token: token ?? this.token,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is User && id == other.id && name == other.name && email == other.email && avatar == other.avatar && token == other.token;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ avatar.hashCode ^ token.hashCode;
}
