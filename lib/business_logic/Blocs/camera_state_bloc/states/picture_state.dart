abstract class PictureState {
  const PictureState();
}

class PictureInitialize extends PictureState {}

class CameraPushing extends PictureState {}

class VideoPushing extends PictureState {}

class TimerIsRunning extends PictureState {
  final int cameraState;
  TimerIsRunning(this.cameraState);
}

class IsRecording extends PictureState {}
