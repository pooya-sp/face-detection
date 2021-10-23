import 'package:video_player/video_player.dart';

class GalleryVideoState {
  const GalleryVideoState();
}

class GalleryVideoInitialized extends GalleryVideoState {}

class GalleryVideoIsLoading extends GalleryVideoState {}

class GalleryVideoLoadingComplete extends GalleryVideoState {
  final VideoPlayerController videoPlayerController;
  GalleryVideoLoadingComplete(this.videoPlayerController);
}

class GalleryVideoLoadingFailed extends GalleryVideoState {}
