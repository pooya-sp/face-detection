import 'package:rwa_deep_ar/rwa_deep_ar.dart';

abstract class FiltersEvent {
  const FiltersEvent();
}

class PreparingCamera extends FiltersEvent {
  final CameraDeepAr cameraDeepAr;
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
