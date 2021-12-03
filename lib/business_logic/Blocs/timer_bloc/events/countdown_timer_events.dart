// import 'package:camera/camera.dart';

abstract class CountDownTimerEvent {
  const CountDownTimerEvent();
}

class SpecifyTimerDuration extends CountDownTimerEvent {
  final int duration;
  const SpecifyTimerDuration(this.duration);
}

class CountDownTimerStarted extends CountDownTimerEvent {}

class CountDownTimerTicked extends CountDownTimerEvent {
  final int secondsToEnd;
  CountDownTimerTicked(this.secondsToEnd);
}

class CountDownTimerEnded extends CountDownTimerEvent {}

class NavBarHasChanged extends CountDownTimerEvent {}
