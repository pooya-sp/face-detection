import 'package:rwa_deep_ar/rwa_deep_ar.dart';

abstract class FiltersState {
  const FiltersState();
}

class InitializingFilters extends FiltersState {}

class FiltersPrepared extends FiltersState {
  final CameraDeepAr cameraDeepAr;
  FiltersPrepared(this.cameraDeepAr);
}

class MasksHasChanged extends FiltersState {
  int currentMask;
  int currentFilter;
  int currentEffect;
  MasksHasChanged({this.currentEffect, this.currentFilter, this.currentMask});
}
