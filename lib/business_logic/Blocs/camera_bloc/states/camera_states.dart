import 'package:camera/camera.dart';

abstract class CameraStates {
  const CameraStates();
}

class CameraInitialize extends CameraStates {}

class CameraIsLoading extends CameraStates {}

class CameraLoadingSuccess extends CameraStates {
  final CameraController controller;
  final double minZoomLevel;
  final double maxZoomLevel;
  CameraLoadingSuccess(this.controller, this.minZoomLevel, this.maxZoomLevel);
}

class CameraLoadingFailed extends CameraStates {}
