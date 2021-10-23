import 'package:photo_gallery/photo_gallery.dart';
import 'package:video_player/video_player.dart';

abstract class GalleryVideoEvent {
  GalleryVideoEvent();
}

class GalleryVideoInitialize extends GalleryVideoEvent {
  final Medium medium;
  GalleryVideoInitialize(this.medium);
}

class MakePLayIconHidden extends GalleryVideoEvent {}

class PauseRequested extends GalleryVideoEvent {}

class PlayRequested extends GalleryVideoEvent {}

class ChangeVolumeRequested extends GalleryVideoEvent {}

class DisposeRequested extends GalleryVideoEvent {}
