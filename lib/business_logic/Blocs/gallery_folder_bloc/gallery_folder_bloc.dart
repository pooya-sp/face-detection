import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/events/gallery_folder_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/states/gallery_folder_states.dart';
import 'package:face_detection_app/data/gallery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class GalleryFolderBloc extends Bloc<GalleryFolderEvent, GalleryFolderState> {
  GalleryFolderBloc() : super(GalleryFolderInitialized());
  Map<String, List<Medium>> media = {};
  Gallery gallery = Gallery();
  @override
  Stream<GalleryFolderState> mapEventToState(GalleryFolderEvent event) async* {
    if (event is GalleryFolderInitializeRequested) {
      yield FolderIsLoading();
      media = {};
      if (event.mediumType != null) {
        media = await gallery.getMedia(event.mediumType);
      } else {
        media = await gallery.getAllMedia();
      }
      yield FoldersLoadingComplete(media);
    }
  }
}
