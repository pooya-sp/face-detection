import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/events/record.events.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/record_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/states/record_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:face_detection_app/data/FileSaver.dart';
import 'package:face_detection_app/screens/display_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

class RecordWidget extends StatelessWidget {
  final CameraDeepArController _controller;

  RecordWidget(this._controller);

  @override
  Widget build(BuildContext context) {
    _controller.startVideoRecording();
    return BlocBuilder<RecordBloc, RecordState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (state is PauseVideo)
          //   Container(
          //     margin: EdgeInsets.only(right: 32),
          //     child: FloatingActionButton(
          //       heroTag: "btn6",
          //       backgroundColor: Colors.transparent,
          //       onPressed: () {
          //         context.read<RecordBloc>().add(ResumeRequested());
          //         context.read<TimerBloc>().add(TimerResumed());
          //         // _controller.resumeVideoRecording();
          //       },
          //       child: Icon(
          //         Icons.fiber_manual_record,
          //         color: Colors.red,
          //       ),
          //     ),
          //   ),
          // if (state is ResumeVideo || state is RecordIsStarting)
          //   Container(
          //     margin: EdgeInsets.only(right: 32),
          //     child: FloatingActionButton(
          //       heroTag: "btn5",
          //       backgroundColor: Colors.transparent,
          //       onPressed: () {
          //         context.read<RecordBloc>().add(PauseRequested());
          //         // _controller.pauseVideoRecording();
          //         context.read<TimerBloc>().add(TimerPaused());
          //       },
          //       child: Icon(Icons.pause),
          //     ),
          //   ),
          FloatingActionButton(
            heroTag: "btn7",
            backgroundColor: Colors.white,
            onPressed: () {
              context.read<RecordBloc>().add(StopVideoRequested());
              _controller.stopVideoRecording().then(
                (video) {
                  context.read<CameraStateBloc>().add(VideoRequested());
                  context.read<TimerBloc>().add(TimerReset());
                },
              );
            },
            child: Icon(
              Icons.stop,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      );
    });
  }
}
