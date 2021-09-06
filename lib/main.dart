import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/back_button_bloc.dart';
import 'package:face_detection_app/screens/camera_screen/camera_screen.dart';
import 'package:face_detection_app/screens/display_picture_screen.dart';
import 'package:face_detection_app/screens/display_video_screen.dart';
import 'package:face_detection_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CameraBloc()),
        BlocProvider(create: (context) => BackButtonBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homescreen(),
        routes: {
          CameraScreen.routName: (_) => CameraScreen(),
          DisplayPictureScreen.routName: (_) => DisplayPictureScreen(),
          DisplayVideoScreen.routName: (_) => DisplayVideoScreen(),
        },
      ),
    );
  }
}
