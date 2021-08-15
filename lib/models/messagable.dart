import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/picture.dart';
import 'model.dart';

class Messagable extends Model {
  const Messagable({
    required this.id,
    required this.name,
    required this.picture,
    this.isGroup = false,
  });
  final int id;
  final String name;
  final bool isGroup;
  final Picture picture;


}
