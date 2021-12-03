import 'dart:typed_data';

import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryState {
  const GalleryState();
}

class GalleryInitialized extends GalleryState {}

class GalleryIsLoading extends GalleryState {}

class GalleryLoadingComplete extends GalleryState {}

class ItemChanged extends GalleryState {
  ItemChanged();
}
