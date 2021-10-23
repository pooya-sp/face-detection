import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/back_button_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/countdown_timer_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:face_detection_app/data/FileSaver.dart';
import 'package:face_detection_app/screens/camera_screen/camera_icon_buttons.dart';
import 'package:face_detection_app/screens/camera_screen/fab_widget.dart';
import 'package:face_detection_app/screens/camera_screen/navigation_bar_camera_screen.dart';
import 'package:face_detection_app/screens/camera_screen/timer_widget.dart';
import 'package:face_detection_app/screens/display_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class CameraScreen extends StatefulWidget {
  static const routName = '/camera';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var _isFrontCamera = false;
  double zoom = 1.0;
  double _scaleFactor = 1.0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BackButtonBloc>(context).add(PictureRequested());
  }

  void handlePermissions() async {
    await Permission.storage.request();
    await Permission.location.request();
    await Permission.accessMediaLocation.request();
    Permission.manageExternalStorage.request();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraStates>(
      builder: (context, state) {
        if (state is CameraIsLoading) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (state is CameraLoadingSuccess) {
            // handlePermissions();
            return BlocBuilder<BackButtonBloc, PictureState>(
              builder: (ctx, st) {
                return WillPopScope(
                  onWillPop: () async {
                    if (st is IsRecording) {
                      final video = await state.controller.stopVideoRecording();
                      FileSaver.saveFileToStorage(video);
                      ctx.read<TimerBloc>().add(TimerReset());
                      ctx.read<BackButtonBloc>().add(VideoRequested());
                      return false;
                    } else if (st is TimerIsRunning) {
                      if (st.cameraState == 0) {
                        context.read<BackButtonBloc>().add(PictureRequested());
                      } else {
                        context.read<BackButtonBloc>().add(VideoRequested());
                      }
                      context
                          .read<CountDownTimerBloc>()
                          .add(CountDownTimerEnded());
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
                                  if (_scaleFactor >= state.minZoomLevel &&
                                      _scaleFactor <= state.maxZoomLevel) {
                                    debugPrint('Gesture updated');
                                    state.controller.setZoomLevel(_scaleFactor);
                                  }
                                },
                                child: CameraPreview(state.controller))),
                        if (st is IsRecording)
                          Positioned(
                            child: TimerWidget(),
                            top: 40,
                            right: 10,
                          ),
                        if (!(st is IsRecording || st is TimerIsRunning))
                          CameraIconButtons(state.controller),
                        BlocConsumer<CountDownTimerBloc, CountDownTimerState>(
                            listener: (ctx, timerState) async {
                          if (timerState is CountDownTimerInitial) {
                            if (st is TimerIsRunning) {
                              if (st.cameraState == 0) {
                                final image =
                                    await state.controller.takePicture();
                                FileSaver.saveFileToStorage(image);
                                Navigator.of(context).pushNamed(
                                    DisplayPictureScreen.routName,
                                    arguments: image.path);
                                context
                                    .read<BackButtonBloc>()
                                    .add(PictureRequested());
                              } else {
                                context
                                    .read<BackButtonBloc>()
                                    .add(RecordRequested());
                              }
                            }
                            if (st is CameraPushing) {
                              state.controller.takePicture().then((image) {
                                FileSaver.saveFileToStorage(image);
                                Navigator.of(context).pushNamed(
                                    DisplayPictureScreen.routName,
                                    arguments: image.path);
                              });
                            }
                            if (st is VideoPushing) {
                              context
                                  .read<BackButtonBloc>()
                                  .add(RecordRequested());
                            }
                          }
                        }, builder: (ctx, timerState) {
                          if (timerState is CountDownTimerRunInProgress) {
                            return Positioned(
                              // top: MediaQuery.of(context).padding.top,
                              left: 40.w,
                              child: Text(
                                '${timerState.seconds}',
                                style: TextStyle(
                                    fontSize: 100, color: Colors.white),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        })
                      ],
                    ),
                    bottomNavigationBar:
                        !(st is TimerIsRunning || st is IsRecording)
                            ? NavigationBar()
                            : null,
                    floatingActionButton: !(st is TimerIsRunning)
                        ? FabWidget(state.controller)
                        : null,
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

  PreferredSizeWidget appBar(st) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [
        if (!(st is TimerIsRunning || st is IsRecording))
          IconButton(
              onPressed: () {
                if (_isFrontCamera) {
                  _isFrontCamera = false;
                  BlocProvider.of<CameraBloc>(context, listen: false)
                      .add(CameraRequested(0));
                } else {
                  _isFrontCamera = true;
                  BlocProvider.of<CameraBloc>(context, listen: false)
                      .add(CameraRequested(1));
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
