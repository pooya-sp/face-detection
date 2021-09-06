import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/picture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackButtonBloc extends Bloc<PictureEvent, PictureState> {
  BackButtonBloc() : super(PictureInitialize());

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
    if (event is BackButtonRequested || event is InitializeRequested) {
      yield PictureInitialize();
    }
    if (event is PictureRequested) {
      yield CameraPushing();
    }
    if (event is VideoRequested) {
      yield VideoPushing();
    }
    if (event is RecordRequested) {
      yield IsRecording();
    }
  }
}
