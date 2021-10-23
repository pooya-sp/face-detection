import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/back_button_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/states/picture_state.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/countdown_timer_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/timer_states.dart';
import 'package:face_detection_app/screens/filters_screen.dart';
import 'package:face_detection_app/screens/gallery/gallery_folders.dart';
import 'package:face_detection_app/screens/gallery/gallery_widget.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/record_bloc.dart';
import 'package:face_detection_app/data/FileSaver.dart';
import 'package:face_detection_app/screens/camera_screen/record_widget.dart';
import 'package:face_detection_app/screens/display_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FabWidget extends StatefulWidget {
  final CameraController _controller;
  FabWidget(this._controller);

  static void showGalleryFolders(BuildContext ctx, bool isMultiple) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) {
          return GalleryFolders();
        }).whenComplete(() {
      if (isMultiple) {
        BlocProvider.of<GalleryFolderBloc>(ctx, listen: false)
            .add(GalleryFolderInitializeRequested(MediumType.image));
      }
    });
  }

  @override
  State<FabWidget> createState() => _FabWidgetState();
}

class _FabWidgetState extends State<FabWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackButtonBloc, PictureState>(builder: (ctx, state) {
      print('back button state is $state');
      if (state is IsRecording) {
        return BlocProvider(
          create: (_) => RecordBloc(),
          child: RecordWidget(widget._controller),
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
                      Navigator.of(context).pushNamed(FiltersScreen.routeName);
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
                  onPressed: () {
                    if (state is CameraPushing) {
                      BlocProvider.of<BackButtonBloc>(context, listen: false)
                          .add(TimerIsOn(0));
                    } else {
                      BlocProvider.of<BackButtonBloc>(context, listen: false)
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
                      FabWidget.showGalleryFolders(context, false);
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
