abstract class FiltersState {
  const FiltersState();
}

class InitializingFilters extends FiltersState {}

class FiltersPrepared extends FiltersState {
  final dynamic cameraDeepAr;
  FiltersPrepared(this.cameraDeepAr);
}

class MasksHasChanged extends FiltersState {
  int currentMask;
  int currentFilter;
  int currentEffect;
  MasksHasChanged({this.currentEffect, this.currentFilter, this.currentMask});
}
