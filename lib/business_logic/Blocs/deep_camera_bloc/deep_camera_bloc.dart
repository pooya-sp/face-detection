import 'package:face_detection_app/business_logic/Blocs/deep_camera_bloc/events/deep_camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/deep_camera_bloc/states/deep_camera_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeepCameraBloc extends Bloc<DeepCameraEvnets, DeepCameraStates> {
  DeepCameraBloc(DeepCameraStates initialState) : super(initialState);
  @override
  Stream<DeepCameraStates> mapEventToState(DeepCameraEvnets event) async* {}
}
