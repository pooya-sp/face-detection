import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/record_bloc.dart';
import 'package:face_detection_app/business_logic/back_button_bloc.dart';
import 'package:face_detection_app/screens/camera_screen/camera_screen.dart';
import 'package:face_detection_app/screens/camera_screen/record_widget.dart';
import 'package:face_detection_app/screens/display_picture_screen.dart';
import 'package:face_detection_app/screens/display_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FabWidget extends StatefulWidget {
  final CameraController _controller;
  FabWidget(this._controller);
  @override
  _FabWidgetState createState() => _FabWidgetState();
}

class _FabWidgetState extends State<FabWidget> {
  // @override
  // void dispose() {
  //   super.dispose();
  //   widget._controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackButtonBloc, PictureState>(
      builder: (context, state) {
        if (state is PictureInitialize) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.transparent,
                heroTag: "btn1",
                onPressed: () {
                  context.read<BackButtonBloc>().add(PictureRequested());
                },
                child: const Icon(Icons.camera_alt),
              ),
              FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    context.read<BackButtonBloc>().add(VideoRequested());
                  },
                  child: Icon(Icons.videocam)),
              FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Colors.transparent,
                onPressed: () {},
                child: Icon(Icons.photo),
              ),
            ],
          );
        }
        if (state is CameraPushing || state is VideoPushing) {
          return Container(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              heroTag: "btn4",
              backgroundColor: Colors.white,
              onPressed: () async {
                try {
                  if (state is CameraPushing) {
                    final image = await widget._controller.takePicture();
                    Navigator.of(context).pushNamed(
                        DisplayPictureScreen.routName,
                        arguments: image.path);
                  } else {
                    context.read<BackButtonBloc>().add(RecordRequested());
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          );
        }
        if (state is IsRecording) {
          return BlocProvider(
            create: (_) => RecordBloc(),
            child: RecordWidget(widget._controller),
          );
        }
        return Center();
      },
    );
  }
}
 // if (_videoState != VideoState.NOT_RECORDING)
        //   FloatingActionButton(
        //       heroTag: "btn4",
        //       backgroundColor: Colors.transparent,
        //       onPressed: () {
        //         if (_videoState == VideoState.RECORDING ||
        //             _videoState == VideoState.RESUME) {
        //           widget._controller.pauseVideoRecording().then((_) {
        //             setState(() {
        //               _videoState = VideoState.PAUSE;
        //             });
        //           });
        //         }

        //         if (_videoState == VideoState.PAUSE) {
        //           widget._controller.resumeVideoRecording().then((_) {
        //             setState(() {
        //               _videoState = VideoState.RESUME;
        //             });
        //           });
        //         }
        //       },
        //       child: Icon(_videoState == VideoState.RECORDING ||
        //               _videoState == VideoState.RESUME
        //           ? Icons.pause
        //           : Icons.videocam)),
        // if (_videoState != VideoState.NOT_RECORDING)
        //   FloatingActionButton(
        //     heroTag: "btn3",
        //     backgroundColor: Colors.transparent,
        //     onPressed: () async {
        //       final video = await widget._controller.stopVideoRecording();
        //       setState(() {
        //         _videoState = VideoState.NOT_RECORDING;
        //       });
        //       Navigator.of(context).pushNamed(DisplayVideoScreen.routName,
        //           arguments: video.path);
        //     },
        //     child: Icon(Icons.stop),
        //   ),
        