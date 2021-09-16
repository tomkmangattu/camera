part of 'cam_cubit.dart';

@immutable
abstract class CamState {}

class CamInitial extends CamState {}

class CamLoaded extends CamState {}

// class ExposureLoaded extends CamState {}

// class ExposureLock extends CamState {}

// class ExposureUnlock extends CamState {}

class CamError extends CamState {
  final String message;
  CamError({required this.message});
}

class CamFlashError extends CamState {
  final String message;
  CamFlashError({required this.message});
}

class CamNewFocus extends CamState {
  final double x;
  final double y;
  CamNewFocus({
    required this.x,
    required this.y,
  });
}

class CamFocusDisappear extends CamState {}

class ImageTook extends CamState {
  final String imagePath;
  ImageTook({required this.imagePath});
}

// class CamExposureError extends CamState {
//   final String message;
//   CamExposureError({required this.message});
// }
