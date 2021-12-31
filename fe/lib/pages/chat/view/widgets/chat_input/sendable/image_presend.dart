import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePresend extends StatelessWidget {
  final XFile _image;

  const ImagePresend({Key? key, required XFile image})
      : _image = image,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(
          Size(MediaQuery.of(context).size.width * 0.7, double.infinity)),
      child: Image.file(
        File(_image.path),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
