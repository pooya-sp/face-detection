import 'package:rwa_deep_ar/rwa_deep_ar.dart';

abstract class FiltersEvent {
  const FiltersEvent();
}

class PreparingFilters extends FiltersEvent {
  final CameraDeepAr cameraDeepAr;
  PreparingFilters(this.cameraDeepAr);
}
