import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/back_button_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:face_detection_app/data/FileSaver.dart';
import 'package:face_detection_app/screens/camera_screen/camera_icon_buttons.dart';
import 'package:face_detection_app/screens/camera_screen/fab_widget.dart';
import 'package:face_detection_app/screens/camera_screen/navigation_bar_camera_screen.dart';
import 'package:face_detection_app/screens/camera_screen/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  static const routName = '/camera';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    Permission.storage.request();
    context.read<BackButtonBloc>().add(PictureRequested());
  }

  var _isFrontCamera = false;

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
                                BlocProvider.of<CameraBloc>(context,
                                        listen: false)
                                    .add(CameraRequested(0));
                              } else {
                                _isFrontCamera = true;
                                BlocProvider.of<CameraBloc>(context,
                                        listen: false)
                                    .add(CameraRequested(1));
                              }
                            },
                            icon: Icon(
                              Icons.restart_alt,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    backgroundColor: Colors.black,
                    body: Stack(
                      children: [
                        Positioned.fill(
                          child: CameraPreview(state.controller),
                        ),
                        if (st is IsRecording)
                          Positioned(
                            child: TimerWidget(),
                            top: 40,
                            right: 10,
                          ),
                        if (!(st is IsRecording))
                          CameraIconButtons(state.controller),
                      ],
                    ),
                    floatingActionButton: FabWidget(state.controller),
                    bottomNavigationBar: NavigationBar(),
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
