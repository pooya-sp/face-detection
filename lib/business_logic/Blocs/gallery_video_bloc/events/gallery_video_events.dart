import 'package:photo_gallery/photo_gallery.dart';

class GalleryVideoEvent {
  const GalleryVideoEvent();
}

class GalleryVideoInitialize extends GalleryVideoEvent {
  final Medium medium;
  GalleryVideoInitialize(this.medium);
}

class MakePLayIconHidden extends GalleryVideoEvent {}

class PauseRequested extends GalleryVideoEvent {}

class PlayRequested extends GalleryVideoEvent {}
