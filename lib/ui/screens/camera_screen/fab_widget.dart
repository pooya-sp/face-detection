import 'package:face_detection_app/UI/screens/camera_screen/record_widget.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/data/bottom_sheets.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/record_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FabWidget extends StatelessWidget {
  final dynamic _controller;
  FabWidget(this._controller);

  Widget build(BuildContext context) {
    return BlocBuilder<CameraStateBloc, PictureState>(builder: (ctx, state) {
      if (state is IsRecording) {
        return BlocProvider(
          create: (_) => RecordBloc(),
          child: RecordWidget(_controller),
        );
      } else if (state is TimerIsRunning) {
        return Container();
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(left: 40, bottom: 8),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    onPressed: () {
                      showFilters(ctx, _controller);
                    },
                    child: Icon(
                      Icons.brush,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  'Filters',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 32, bottom: 24),
              child: FloatingActionButton(
                  heroTag: "btn4",
                  backgroundColor:
                      state is CameraPushing ? Colors.white : Colors.red,
                  onPressed: () async {
                    if (state is CameraPushing) {
                      BlocProvider.of<CameraStateBloc>(context, listen: false)
                          .add(TimerIsOn(0));
                    } else {
                      BlocProvider.of<CameraStateBloc>(context, listen: false)
                          .add(TimerIsOn(1));
                    }
                    BlocProvider.of<CountDownTimerBloc>(context, listen: false)
                        .add(CountDownTimerStarted());
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8, right: 24),
                  width: 40,
                  height: 35,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    heroTag: "btn3",
                    onPressed: () {
                      showGalleryFolders(context, false);
                    },
                    child: Icon(
                      Icons.photo,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  child: Text(
                    state is CameraPushing
                        ? 'Gallery Images'
                        : 'Gallery Videos',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    });
  }

  constructor() {}
}
