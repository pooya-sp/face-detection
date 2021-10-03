import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class GalleryEvent {
  const GalleryEvent();
}

class GalleryInitializeRequested extends GalleryEvent {}

class ItemSelected extends GalleryEvent {}
