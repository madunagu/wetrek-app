import 'package:flutter/material.dart';

class TextStyles {
  static final minor = const TextStyle(
    fontSize: 12,
    height: 1.333,
    color: Color(0x88ffffff),
  );
  static final normal = const TextStyle(
    fontSize: 16,
    height: 21 / 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffffffff),
  );

  static final large = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 32 / 24,
  );

  static final darkLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Color(0xff454F63),
    height: 32 / 24,
    fontFamily: 'Gibson',
  );

  static final title = const TextStyle(
    fontSize: 40,
    height: 44 / 40,
    fontWeight: FontWeight.w500,
    color: Color(0xff454F63),
  );

  static final tab = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color(0xff454F63),
    height: 17 / 13,
  );

  static final base = const TextStyle(
    height: 19 / 14,
    color: Color(0xa6ffffff),
  );

  static final darkNormal = const TextStyle(
      color: Color(0xff454F63),
      fontSize: 16,
      height: 21 / 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Gibson');
  static final darkMinor = const TextStyle(
    color: Color(0xff959DAD),
    fontSize: 12,
    height: 16 / 12,
  );

  static final terms = const TextStyle(
    color: Color(0xff78849E),
    fontSize: 14,
//    height: 16 / 12,
  );

  static final input = const TextStyle(
    fontSize: 15,
    color: Color(0xff454F63),
    fontWeight: FontWeight.w500,
    height: 20 / 15,
  );
}
