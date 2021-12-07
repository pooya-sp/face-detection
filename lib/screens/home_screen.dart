import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/screens/camera_screen/camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GalleryFolderBloc>()
        .add(GalleryFolderInitializeRequested(MediumType.image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.camera_alt),
                Text('Take a picture'),
              ],
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pushNamed(
              CameraScreen.routName,
            );
          },
        ),

        // return Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Something went wrong. Please try again',
        //       style:
        //           TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        //     ),
        //     Container(
        //       margin: EdgeInsets.only(top: 12),
        //       child: IconButton(
        //           onPressed: () async {
        //             // final isCameraDenied =
        //             //     await Permission.camera.isDenied;
        //             // final isRecordDenied =
        //             //     await Permission.speech.isDenied;
        //             // print(isCameraDenied);
        //             // print(isRecordDenied);
        //             // if (isCameraDenied || isRecordDenied) {
        //             //   openAppSettings();
        //             // } else {
        //             //   context
        //             //       .read<CameraBloc>()
        //             //       .add(CameraRequested(0));
        //             // }
        //           },
        //           icon: Icon(
        //             Icons.rotate_left,
        //             size: 60,
        //           )),
        //     ),
        //   ],
        // );
      ),
    );
  }
}
