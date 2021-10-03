import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class GalleryFolderEvent {
  const GalleryFolderEvent();
}

class GalleryFolderInitializeRequested extends GalleryFolderEvent {
  final MediumType? mediumType;
  GalleryFolderInitializeRequested(this.mediumType);
}

class DeleteAnItem extends GalleryFolderEvent {}
