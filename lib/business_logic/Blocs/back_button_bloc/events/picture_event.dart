abstract class PictureEvent {
  const PictureEvent();
}

class PictureRequested extends PictureEvent {}

class VideoRequested extends PictureEvent {}

class RecordRequested extends PictureEvent {}
