import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/back_button_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/back_button_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/countdown_timer_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/screens/camera_screen/fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class NavigationBar extends StatefulWidget {
  int _currentIndex = 0;

  NavigationBar._privateConstructor();

  static final NavigationBar _instance = NavigationBar._privateConstructor();

  factory NavigationBar() {
    return _instance;
  }
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            widget._currentIndex = index;
          });
          if (index == 0) {
            BlocProvider.of<BackButtonBloc>(context, listen: false)
                .add(PictureRequested());
            BlocProvider.of<GalleryFolderBloc>(context, listen: false)
                .add(GalleryFolderInitializeRequested(MediumType.image));
            BlocProvider.of<CountDownTimerBloc>(context, listen: false)
                .add(NavBarHasChanged());
          } else if (index == 1) {
            BlocProvider.of<BackButtonBloc>(context, listen: false)
                .add(VideoRequested());
            BlocProvider.of<GalleryFolderBloc>(context, listen: false)
                .add(GalleryFolderInitializeRequested(MediumType.video));
            BlocProvider.of<CountDownTimerBloc>(context, listen: false)
                .add(NavBarHasChanged());
          } else if (index == 2) {
            BlocProvider.of<BackButtonBloc>(context, listen: false)
                .add(PictureRequested());
            BlocProvider.of<GalleryFolderBloc>(context, listen: false)
                .add(GalleryFolderInitializeRequested(null));
            FabWidget.showGalleryFolders(context, true);
            setState(() {
              widget._currentIndex = 0;
            });
          }
        },
        currentIndex: widget._currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Photo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multiple_stop),
            label: 'Multiple',
          ),
        ],
        selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
        unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
      ),
    );
  }
}
