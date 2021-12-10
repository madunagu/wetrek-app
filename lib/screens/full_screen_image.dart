import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage(this.image);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: PhotoView(
        //   imageProvider: NetworkImage(image),
        // ),
      ),
    );
  }
}
