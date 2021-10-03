import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryFolderState {
  const GalleryFolderState();
}

class GalleryFolderInitialized extends GalleryFolderState {}

class FolderIsLoading extends GalleryFolderState {}

class FoldersLoadingComplete extends GalleryFolderState {
  final Map<String, List<Medium>> media;
  FoldersLoadingComplete(this.media);
}
