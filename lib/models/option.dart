import 'package:flutter/material.dart';

class Option {
  const Option({
    required this.title,
    required this.subTitle,
    required this.value,
  });
  final Widget title;
  final String subTitle;
  final String value;
}
