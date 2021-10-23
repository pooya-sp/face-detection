abstract class PictureEvent {
  const PictureEvent();
}

class PictureRequested extends PictureEvent {}

class VideoRequested extends PictureEvent {}

class TimerIsOn extends PictureEvent {
  //picutre=0, video=1
  final int cameraState;
  TimerIsOn(this.cameraState);
}

class RecordRequested extends PictureEvent {}
