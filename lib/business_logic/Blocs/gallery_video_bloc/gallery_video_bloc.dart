import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/events/gallery_video_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/states/gallery_video_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoBloc extends Bloc<GalleryVideoEvent, GalleryVideoState> {
  late VideoPlayerController controller;
  GalleryVideoBloc() : super(GalleryVideoInitialized());

  @override
  Stream<GalleryVideoState> mapEventToState(GalleryVideoEvent event) async* {
    if (event is GalleryVideoInitialize) {
      try {
        final mediumFile = await event.medium.getFile();
        controller = VideoPlayerController.file(mediumFile);
        await controller.initialize();
        yield GalleryVideoLoadingComplete(controller);
      } catch (error) {
        print(error);
        yield GalleryVideoLoadingFailed();
      }
    }
    if (event is MakePLayIconHidden) {
      yield GalleryVideoLoadingComplete(controller);
    }
    if (event is PauseRequested) {
      await controller.pause();
      yield GalleryVideoLoadingComplete(controller);
    }
    if (event is PlayRequested) {
      await controller.play();
      yield GalleryVideoLoadingComplete(controller);
    }
  }
}
