import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/states/picture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraStateBloc extends Bloc<PictureEvent, PictureState> {
  CameraStateBloc() : super(PictureInitialize());

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
    if (event is PictureRequested) {
      yield CameraPushing();
    }
    if (event is TimerIsOn) {
      yield TimerIsRunning(event.cameraState);
    }
    if (event is VideoRequested) {
      yield VideoPushing();
    }
    if (event is RecordRequested) {
      yield IsRecording();
    }
  }
}
