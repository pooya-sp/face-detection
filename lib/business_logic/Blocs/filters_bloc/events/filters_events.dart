abstract class FiltersEvent {
  const FiltersEvent();
}

class PreparingCamera extends FiltersEvent {
  final dynamic cameraDeepAr;
  PreparingCamera(this.cameraDeepAr);
}

class PreparingFilters extends FiltersEvent {
  PreparingFilters();
}

class FiltersReady extends FiltersEvent {}

class ChangeMask extends FiltersEvent {
  int currentMask;
  ChangeMask(this.currentMask);
}

class ChangeFilter extends FiltersEvent {
  int currentFilter;
  ChangeFilter(this.currentFilter);
}

class ChangeEffect extends FiltersEvent {
  int currentEffect;
  ChangeEffect(this.currentEffect);
}
