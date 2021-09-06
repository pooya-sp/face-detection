import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/back_button_bloc.dart';
import 'package:face_detection_app/screens/camera_screen/fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraScreen extends StatefulWidget {
  static const routName = '/camera';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var _isFrontCamera = false;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocBuilder<CameraBloc, CameraStates>(
      builder: (context, state) {
        if (state is CameraIsLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (state is CameraLoadingSuccess) {
            return BlocBuilder<BackButtonBloc, PictureState>(
              builder: (ctx, st) {
                return WillPopScope(
                  onWillPop: () async {
                    if (st is CameraPushing || st is VideoPushing) {
                      ctx.read<BackButtonBloc>().add(BackButtonRequested());
                      return false;
                    } else {
                      Navigator.of(context).pop();
                      return true;
                    }
                  },
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      actions: [
                        IconButton(
                            onPressed: () {
                              if (_isFrontCamera) {
                                _isFrontCamera = false;
                                context
                                    .read<CameraBloc>()
                                    .add(CameraRequested(0));
                              } else {
                                _isFrontCamera = true;
                                context
                                    .read<CameraBloc>()
                                    .add(CameraRequested(1));
                              }
                            },
                            icon: Icon(Icons.cameraswitch)),
                      ],
                    ),
                    backgroundColor: Colors.black,
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(state.controller),
                    ),
                    floatingActionButton: FabWidget(state.controller),
                  ),
                );
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('Something went wrong. Please try again later.'),
              ),
            );
          }
        }
      },
    );
  }
}
