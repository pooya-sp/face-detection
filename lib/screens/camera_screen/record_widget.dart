import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/events/record.events.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/record_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/states/record_states.dart';
import 'package:face_detection_app/business_logic/back_button_bloc.dart';
import 'package:face_detection_app/screens/display_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordWidget extends StatelessWidget {
  final CameraController _controller;
  late Timer _timer;
  RecordWidget(this._controller);
  void _startRecordingVideo() {
    _controller.startVideoRecording();
    _timer = Timer(Duration(), () {});
  }

  @override
  Widget build(BuildContext context) {
    _startRecordingVideo();
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_timer.tick} timer '),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is PauseVideo)
                  FloatingActionButton(
                    heroTag: "btn6",
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      context.read<RecordBloc>().add(ResumeRequested());
                      _controller.resumeVideoRecording();
                    },
                    child: Icon(
                      Icons.fiber_manual_record,
                      color: Colors.red,
                    ),
                  ),
                if (state is ResumeVideo || state is RecordIsStarting)
                  FloatingActionButton(
                    heroTag: "btn5",
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      context.read<RecordBloc>().add(PauseRequested());
                      _controller.pauseVideoRecording();
                    },
                    child: Icon(Icons.pause),
                  ),
                FloatingActionButton(
                    heroTag: "btn7",
                    backgroundColor: Colors.white,
                    onPressed: () {
                      context.read<RecordBloc>().add(StopVideoRequested());
                      _controller.stopVideoRecording().then(
                        (video) {
                          context
                              .read<BackButtonBloc>()
                              .add(InitializeRequested());
                          Navigator.of(context).pushReplacementNamed(
                              DisplayVideoScreen.routName,
                              arguments: video.path);
                        },
                      );
                    },
                    child: Icon(
                      Icons.stop,
                      color: Colors.black,
                      size: 30,
                    )),
              ],
            ),
          ],
        );
      },
    );
  }
}
