import 'dart:async';

import 'package:face_detection_app/UI/screens/camera_screen/camera_icon_buttons.dart';
import 'package:face_detection_app/UI/screens/camera_screen/fab_widget.dart';
import 'package:face_detection_app/UI/screens/camera_screen/navigation_bar_camera_screen.dart';
import 'package:face_detection_app/UI/screens/camera_screen/timer_widget.dart';
import 'package:face_detection_app/UI/screens/display_picture_screen.dart';
import 'package:face_detection_app/UI/screens/display_video_screen.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/events/filters_events.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/filters_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/countdown_timer_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

class CameraScreen extends StatefulWidget {
  static const routName = '/camera';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var _isFrontCamera = true;
  double zoom = 1.0;
  double _scaleFactor = 1.0;
  CameraDeepArController cameraDeepArController;
  CameraDeepAr cameraDeepAr;

  List<Filters> _supportedFilters = [
    Filters.none,
    Filters.sepia,
    Filters.bleachbypass,
  ];
  List<Effects> _supportedEffects = [
    Effects.none,
    Effects.fire,
    Effects.heart,
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CameraStateBloc>(context).add(PictureRequested());
  }

  Widget get deepCamera {
    cameraDeepAr = CameraDeepAr(
      iosLicenceKey: "",
      supportedEffects: _supportedEffects,
      supportedFilters: _supportedFilters,
      androidLicenceKey:
          '4780670a9159ad6f18754a738871fc774af54bd0a470985f5bb1c0bb3d63512f794e78db339d66ce',
      onCameraReady: (_) {},
      onVideoRecorded: (videoPath) {
        Navigator.of(context)
            .pushNamed(DisplayVideoScreen.routName, arguments: videoPath);
      },
      onImageCaptured: (imagePath) {
        Navigator.of(context)
            .pushNamed(DisplayPictureScreen.routName, arguments: imagePath);
      },
      cameraDeepArCallback: (controller) {
        cameraDeepArController = controller;
      },
    );
    print(cameraDeepAr != null);
    print(cameraDeepArController != null);
    BlocProvider.of<FiltersBloc>(context).add(PreparingCamera(cameraDeepAr));
    return cameraDeepAr;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraStateBloc, PictureState>(
      builder: (ctx, st) {
        return WillPopScope(
          onWillPop: () async {
            if (st is IsRecording) {
              await cameraDeepArController.stopVideoRecording();
              // FileSaver.saveFileToStorage(video);
              ctx.read<TimerBloc>().add(TimerReset());
              ctx.read<CameraStateBloc>().add(VideoRequested());
              return false;
            } else if (st is TimerIsRunning) {
              if (st.cameraState == 0) {
                context.read<CameraStateBloc>().add(PictureRequested());
              } else {
                context.read<CameraStateBloc>().add(VideoRequested());
              }
              context.read<CountDownTimerBloc>().add(CountDownTimerEnded());
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar(st),
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Positioned.fill(
                    child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onScaleStart: (details) {
                    zoom = _scaleFactor;
                  },
                  onScaleUpdate: (details) {
                    _scaleFactor = zoom * details.scale;
                    // if (_scaleFactor >= state.minZoomLevel &&
                    //     _scaleFactor <= state.maxZoomLevel) {
                    //   debugPrint('Gesture updated');
                    //   state.controller.setZoomLevel(_scaleFactor);
                    // }
                  },
                  child: deepCamera,
                )),
                if (st is IsRecording)
                  Positioned(
                    child: TimerWidget(),
                    top: 40,
                    right: 10,
                  ),
                if (!(st is IsRecording || st is TimerIsRunning))
                  CameraIconButtons(),
                BlocConsumer<CountDownTimerBloc, CountDownTimerState>(
                    listener: (ctx, timerState) async {
                  if (timerState is CountDownTimerInitial) {
                    if (st is TimerIsRunning) {
                      if (st.cameraState == 0) {
                        print('snap timer');
                        cameraDeepArController.snapPhoto();
                        // context.read<CameraStateBloc>().add(PictureRequested());
                      } else {
                        context.read<CameraStateBloc>().add(RecordRequested());
                      }
                    }
                    if (st is CameraPushing) {
                      print('snap camera');
                      cameraDeepArController.snapPhoto();
                    }
                    if (st is VideoPushing) {
                      context.read<CameraStateBloc>().add(RecordRequested());
                    }
                  }
                }, builder: (ctx, timerState) {
                  if (timerState is CountDownTimerRunInProgress) {
                    return Positioned(
                      // top: MediaQuery.of(context).padding.top,
                      left: 40.w,
                      child: Text(
                        '${timerState.seconds}',
                        style: TextStyle(fontSize: 100, color: Colors.white),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
            bottomNavigationBar: !(st is TimerIsRunning || st is IsRecording)
                ? NavigationBar()
                : null,
            floatingActionButton: !(st is TimerIsRunning)
                ? FabWidget(cameraDeepArController)
                : null,
          ),
        );
      },
    );
  }

  PreferredSizeWidget appBar(st) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [
        if (!(st is TimerIsRunning || st is IsRecording))
          IconButton(
              onPressed: () async {
                if (_isFrontCamera) {
                  _isFrontCamera = false;
                  cameraDeepArController.switchCameraDirection(
                      direction: CameraDirection.back);
                } else {
                  _isFrontCamera = true;
                  cameraDeepArController.switchCameraDirection(
                      direction: CameraDirection.front);
                }
              },
              icon: Icon(
                Icons.restart_alt,
                color: Colors.white,
              )),
      ],
    );
  }
}
