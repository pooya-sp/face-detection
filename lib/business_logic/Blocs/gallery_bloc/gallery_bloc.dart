import 'package:face_detection_app/business_logic/Blocs/gallery_bloc/events/gallery_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_bloc/states/gallery_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitialized());
  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is GalleryInitializeRequested) {
      yield GalleryLoadingComplete();
    }
    if (event is ItemSelected) {
      yield GalleryLoadingComplete();
    }
  }
}
