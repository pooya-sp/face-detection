import 'package:rwa_deep_ar/rwa_deep_ar.dart';

abstract class FiltersState {
  const FiltersState();
}

class InitializingFilters extends FiltersState {}

class FiltersAreReady extends FiltersState {
  final CameraDeepAr cameraDeepAr;
  FiltersAreReady(this.cameraDeepAr);
}
