import 'package:wetrek/models/model.dart';

class Settings extends Model {
  // final String column;
  final List<String>? names;
  final List<bool> values;
  Settings({this.names, required this.values});

  factory Settings.fromJson(List<dynamic> settings) => Settings(
        names: settings.map((e) => Setting.fromJson(e).name).toList(),
        values: settings.map((e) => Setting.fromJson(e).value).toList(),
      );
}

class Setting extends Model {
  // final String column;
  final String name;
  final bool value;
  Setting({required this.name, required this.value});

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        name: json['name'] as String,
        value: json['point'] != null ? json['point'] == 1 : false,
      );
}
