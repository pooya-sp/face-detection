import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/events/gallery_video_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/states/gallery_video_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoBloc extends Bloc<GalleryVideoEvent, GalleryVideoState> {
  VideoPlayerController videoPlayerController;
  GalleryVideoBloc() : super(GalleryVideoInitialized());
  @override
  Stream<GalleryVideoState> mapEventToState(GalleryVideoEvent event) async* {
    if (event is GalleryVideoInitialize) {
      try {
        yield GalleryVideoIsLoading();
        final mediumFile = await event.medium.getFile();
        videoPlayerController = VideoPlayerController.file(mediumFile);
        await videoPlayerController.initialize();
        yield GalleryVideoLoadingComplete(videoPlayerController);
      } catch (error) {
        print(error);
        yield GalleryVideoLoadingFailed();
      }
    }
    if (event is MakePLayIconHidden) {
      yield GalleryVideoLoadingComplete(videoPlayerController);
    }
    if (event is PauseRequested) {
      await videoPlayerController.pause();
      yield GalleryVideoLoadingComplete(videoPlayerController);
    }
    if (event is PlayRequested) {
      await videoPlayerController.play();
      yield GalleryVideoLoadingComplete(videoPlayerController);
    }
    if (event is ChangeVolumeRequested) {
      yield GalleryVideoLoadingComplete(videoPlayerController);
    }
  }
}
