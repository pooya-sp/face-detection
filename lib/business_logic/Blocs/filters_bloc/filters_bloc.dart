import 'package:face_detection_app/business_logic/Blocs/filters_bloc/events/filters_events.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/states/filters.states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(InitializingFilters());
  int currentMask = 0;
  int currentFilter = 0;
  int currentEffect = 0;
  dynamic cameraDeepAr;
  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is PreparingCamera) {
      cameraDeepAr = event.cameraDeepAr;
    }
    if (event is PreparingFilters) {
      yield FiltersPrepared(cameraDeepAr);
    }
    if (event is FiltersReady) {
      yield MasksHasChanged(
          currentEffect: currentEffect,
          currentFilter: currentFilter,
          currentMask: currentMask);
    }
    if (event is ChangeMask) {
      currentMask = event.currentMask;

      yield MasksHasChanged(
          currentEffect: currentEffect,
          currentFilter: currentFilter,
          currentMask: currentMask);
    }
    if (event is ChangeFilter) {
      currentFilter = event.currentFilter;
      yield MasksHasChanged(
          currentEffect: currentEffect,
          currentFilter: currentFilter,
          currentMask: currentMask);
    }
    if (event is ChangeEffect) {
      currentEffect = event.currentEffect;
      yield MasksHasChanged(
          currentEffect: currentEffect,
          currentFilter: currentFilter,
          currentMask: currentMask);
    }
  }
}
