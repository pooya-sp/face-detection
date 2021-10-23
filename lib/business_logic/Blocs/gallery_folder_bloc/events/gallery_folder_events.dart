import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryFolderEvent {
  const GalleryFolderEvent();
}

class GalleryFolderInitializeRequested extends GalleryFolderEvent {
  final MediumType mediumType;
  GalleryFolderInitializeRequested(this.mediumType);
}

class DeleteAnItem extends GalleryFolderEvent {}
