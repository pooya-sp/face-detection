import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraBloc extends Bloc<CameraEvents, CameraStates> {
  CameraBloc() : super(CameraInitialize());
  late CameraController _controller;

  @override
  Stream<CameraStates> mapEventToState(CameraEvents event) async* {
    yield CameraIsLoading();
    try {
      if (event is CameraRequested) {
        List<CameraDescription> cameras = await availableCameras();
        _controller =
            CameraController(cameras[event.camera], ResolutionPreset.max);
        await _controller.initialize();
        print(event.camera);
        yield CameraLoadingSuccess(_controller);
      }
    } catch (error) {
      yield CameraLoadingFailed();
    }
  }

  @override
  Future<void> close() {
    if (_controller != null) {
      _controller.dispose();
    }
    return super.close();
  }
}
