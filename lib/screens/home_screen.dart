import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/screens/camera_screen/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<CameraBloc>().add(CameraRequested(0));
    context
        .read<GalleryFolderBloc>()
        .add(GalleryFolderInitializeRequested(MediumType.image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CameraBloc, CameraStates>(
          builder: (context, state) {
            if (state is CameraIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (state is CameraLoadingSuccess) {
                return ElevatedButton(
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CameraScreen.routName,
                    );
                  },
                );
              } else {
                return Text('Something went wrong. Please try again later');
              }
            }
          },
        ),
      ),
    );
  }
}
