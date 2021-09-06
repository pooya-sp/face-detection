abstract class RecordEvent {
  const RecordEvent();
}

class PauseRequested extends RecordEvent {}

class ResumeRequested extends RecordEvent {}

class StopVideoRequested extends RecordEvent {}
