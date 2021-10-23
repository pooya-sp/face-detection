import 'package:equatable/equatable.dart';

abstract class CountDownTimerState {
  const CountDownTimerState();
}

class CountDownTimerInitial extends CountDownTimerState {}

class CountDownTimerRunInProgress extends CountDownTimerState {
  final int seconds;
  CountDownTimerRunInProgress(this.seconds);
}

class CountDownTimerHasEnded extends CountDownTimerState {}
