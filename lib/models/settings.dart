import 'package:wetrek/models/model.dart';

class Settings extends Model {
  // final String column;
  final List<String>? names;
  final List<bool> values;
  Settings({this.names, required this.values});

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        names: json['names'] as List<String>,
        values: json['values'] as List<bool>,
      );
}
