import 'package:camera/camera.dart';

abstract class CameraStates {
  const CameraStates();
}

class CameraInitialize extends CameraStates {}

class CameraIsLoading extends CameraStates {}

class CameraLoadingSuccess extends CameraStates {
  final CameraController controller;
  CameraLoadingSuccess(this.controller);
}

class CameraLoadingFailed extends CameraStates {}
