import 'package:flutter/foundation.dart';


@immutable
class Notification {

  const Notification({
    required this.id,
  });

  final int id;

  factory Notification.fromJson(Map<String,dynamic> json) => Notification(
    id: json['id'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'id': id
  };

  Notification clone() => Notification(
    id: id
  );


  Notification copyWith({
    int? id
  }) => Notification(
    id: id ?? this.id,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Notification && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
