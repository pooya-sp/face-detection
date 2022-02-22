import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:face_detection_app/UI/screens/camera_screen/camera_screen.dart';
import 'package:face_detection_app/UI/screens/display_gallery_media.dart';
import 'package:face_detection_app/UI/screens/display_picture_screen.dart';
import 'package:face_detection_app/UI/screens/display_video_screen.dart';
import 'package:face_detection_app/UI/screens/home_screen.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/filters_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_items_bloc/gallery_items_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/gallery_video_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:face_detection_app/data/Ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('ARCORE IS AVAILABLE?');
  print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  print(await ArCoreController.checkIsArCoreInstalled());
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  GalleryApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountDownTimerBloc()),
        BlocProvider(create: (_) => FiltersBloc()),
        BlocProvider(create: (_) => GalleryFolderBloc()),
        BlocProvider(create: (_) => GalleryItemsBloc()),
        BlocProvider(create: (_) => CameraStateBloc()),
        BlocProvider(create: (_) => TimerBloc(ticker: Ticker())),
        BlocProvider(create: (_) => GalleryVideoBloc()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
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
            DisplayGalleryMedia.routeName: (_) => DisplayGalleryMedia(),
          },
        );
      }),
    );
  }
}
