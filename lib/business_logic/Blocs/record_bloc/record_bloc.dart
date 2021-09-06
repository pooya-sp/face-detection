import 'package:face_detection_app/business_logic/Blocs/record_bloc/events/record.events.dart';
import 'package:face_detection_app/business_logic/Blocs/record_bloc/states/record_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  RecordBloc() : super(RecordIsStarting());

  @override
  Stream<RecordState> mapEventToState(RecordEvent event) async* {
    if (event is PauseRequested) {
      yield PauseVideo();
    }
    if (event is ResumeRequested) {
      yield ResumeVideo();
    }
    if (event is StopVideoRequested) {
      yield VideoStopped();
    }
  }
}
