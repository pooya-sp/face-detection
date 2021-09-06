abstract class PictureState {
  const PictureState();
}

class PictureInitialize extends PictureState {}

class CameraPushing extends PictureState {}

class VideoPushing extends PictureState {}

class IsRecording extends PictureState {}
