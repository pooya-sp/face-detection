abstract class PictureEvent {
  const PictureEvent();
}

class InitializeRequested extends PictureEvent {}

class BackButtonRequested extends PictureEvent {}

class PictureRequested extends PictureEvent {}

class VideoRequested extends PictureEvent {}

class RecordRequested extends PictureEvent {}
