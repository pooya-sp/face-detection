import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DisplayPictureScreen extends StatelessWidget {
  static const routName = 'display-picture';

  @override
  Widget build(BuildContext context) {
    String filePath = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.file(File(filePath))),
    );
  }
}
