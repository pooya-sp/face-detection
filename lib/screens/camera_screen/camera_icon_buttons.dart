import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FlashState {
  OFF,
  ON,
  AUTO,
}

class CameraIconButtons extends StatefulWidget {
  final CameraController _controller;
  const CameraIconButtons(this._controller);
  @override
  State<CameraIconButtons> createState() => _CameraIconButtonsState();
}

class _CameraIconButtonsState extends State<CameraIconButtons> {
  FlashState _flashState = FlashState.OFF;
  int timerMode = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top - 5),
      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: Text(
            'Switch Camera',
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ),
        IconButton(
            onPressed: () {
              if (timerMode == 0) {
                setState(() {
                  timerMode = 3;
                  BlocProvider.of<CountDownTimerBloc>(context)
                      .add(SpecifyTimerDuration(3));
                });
              } else if (timerMode == 3) {
                setState(() {
                  timerMode = 10;
                  BlocProvider.of<CountDownTimerBloc>(context)
                      .add(SpecifyTimerDuration(10));
                });
              } else if (timerMode == 10) {
                setState(() {
                  timerMode = 0;
                  BlocProvider.of<CountDownTimerBloc>(context)
                      .add(SpecifyTimerDuration(0));
                });
              }
            },
            icon: Icon(
              timerMode == 0
                  ? Icons.timer_off
                  : timerMode == 3
                      ? Icons.timer_3
                      : Icons.timer_10,
              color: Colors.white,
            )),
        Container(
          width: 36,
          alignment: Alignment.centerLeft,
          child: Text(
            'Timer',
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ),
        IconButton(
            onPressed: () {
              if (_flashState == FlashState.OFF) {
                widget._controller.setFlashMode(FlashMode.always);
                setState(() {
                  _flashState = FlashState.ON;
                });
              } else if (_flashState == FlashState.ON) {
                widget._controller.setFlashMode(FlashMode.auto);
                setState(() {
                  _flashState = FlashState.AUTO;
                });
              } else if (_flashState == FlashState.AUTO) {
                widget._controller.setFlashMode(FlashMode.off);
                setState(() {
                  _flashState = FlashState.OFF;
                });
              }
            },
            icon: Icon(
              _flashState == FlashState.ON
                  ? Icons.flash_on
                  : _flashState == FlashState.OFF
                      ? Icons.flash_off
                      : Icons.flash_auto,
              color: Colors.white,
            )),
        Container(
          width: 36,
          alignment: Alignment.centerLeft,
          child: Text(
            'Flash',
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        )
      ]),
    );
  }
}
