import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryEvent {
  const GalleryEvent();
}

class GalleryInitializeRequested extends GalleryEvent {}

class ItemSelected extends GalleryEvent {}
