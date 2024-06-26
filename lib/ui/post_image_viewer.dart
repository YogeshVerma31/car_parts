import 'package:flutter/material.dart';
import '../utils/styles.dart';

class PhotoViewerScreen extends StatelessWidget {
  String? imageUrl;

  PhotoViewerScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Photo',
            style: headingStyle.copyWith(color: Colors.white),
          ),
        ),
        body: Center(
          child: Image.network(imageUrl!,),
        ));
  }
}
