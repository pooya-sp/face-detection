abstract class CameraEvents {
  const CameraEvents();
}

class CameraRequested extends CameraEvents {
  final int camera;
  CameraRequested(this.camera);
}
