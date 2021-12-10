import 'package:flutter/material.dart';

class AvatarList extends StatelessWidget {
  AvatarList({required this.imgSrcs});
  final List<String> imgSrcs;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: imgSrcs
            .map(
              (String src) => Padding(
            padding: EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(src, width: 32, height: 32),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}