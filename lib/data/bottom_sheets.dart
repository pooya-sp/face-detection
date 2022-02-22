import 'package:face_detection_app/UI/screens/camera_screen/tab_bar_widget.dart';
import 'package:face_detection_app/UI/screens/gallery/gallery_folders.dart';
import 'package:face_detection_app/UI/screens/gallery/gallery_widget.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

void showFilters(BuildContext ctx, dynamic cameraDeepArController) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.white,
      context: ctx,
      builder: (_) {
        print('bottom sheet rebuild');
        return TabBarWidget();
      });
}

void showGalleryFolders(BuildContext ctx, bool isMultiple) {
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

void showGalleryPictures(
  BuildContext ctx,
  String albumName,
  List<Medium> album,
) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Scaffold(body: GalleryWidget(albumName, album)));
}
