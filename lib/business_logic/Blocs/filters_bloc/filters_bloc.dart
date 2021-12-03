import 'package:face_detection_app/business_logic/Blocs/filters_bloc/events/filters_events.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/states/filters.states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(InitializingFilters());
  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is PreparingFilters) {
      yield FiltersAreReady(event.cameraDeepAr);
    }
  }
}
