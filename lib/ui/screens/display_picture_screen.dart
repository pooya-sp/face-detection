import 'dart:io';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayPictureScreen extends StatefulWidget {
  static const routName = 'display-picture';

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CameraStateBloc>().add(PictureRequested());
    var filePath = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          // File(filePath),
          "https://media.cntraveller.com/photos/611bf0b8f6bd8f17556db5e4/16:9/w_2992,h_1683,c_limit/gettyimages-1146431497.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
