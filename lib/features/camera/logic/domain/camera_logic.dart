import 'dart:async';
import 'package:camera/camera.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';

class CamLogic {
  FlashMode flashMode;
  ResolutionPreset resolutionPreset;
  late final CameraController cameraController;
  late final List<CameraDescription> _cameraDescription;
  bool _isControllerInitialised = false;

  CamLogic({
    this.flashMode = FlashMode.always,
    this.resolutionPreset = ResolutionPreset.max,
  });

  // true if initialisation is sucess
  // false if initialisation is failure

  Future<bool> initCam() async {
    try {
      _cameraDescription = await availableCameras();
      if (_cameraDescription.isNotEmpty) {
        cameraController = CameraController(
          _cameraDescription[0],
          resolutionPreset,
        );
        await cameraController.initialize().then((_) {
          _isControllerInitialised = true;
          cameraController.setFlashMode(flashMode);
        });
        return true;
      }
    } on CameraException catch (_) {
      return false;
    }
    return false;
  }

  // true if flashMode is set
  Future<bool> switchFlashMode(final FlashMode flashMode) async {
    if (_isControllerInitialised) {
      try {
        if (this.flashMode == FlashMode.torch) {
          cameraController.setFlashMode(FlashMode.off);
          await Future.delayed(const Duration(milliseconds: 10));
          this.flashMode = flashMode;
        } else {
          this.flashMode = flashMode;
        }
        await cameraController.setFlashMode(this.flashMode);
        return true;
      } catch (_) {
        return false;
      }
    }
    return false;
  }

  // change resolution
  void changeFocus(Offset offset) async {
    if (_isControllerInitialised) {
      try {
        await cameraController.setExposurePoint(offset);
        await cameraController.setFocusPoint(offset);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  // true if got exposure offsets
  //
  // Future<Either<String, CamExposureOffsets>> getOffsets() async {
  //   if (_isControllerInitialised) {
  //     double maxExpOffset = 0;
  //     double minExpOffset = 0;
  //     try {
  //       await Future.wait([
  //         cameraController.getMaxExposureOffset().then(
  //               (double offset) => maxExpOffset = offset,
  //             ),
  //         cameraController.getMinExposureOffset().then(
  //               (double offset) => minExpOffset = offset,
  //             ),
  //       ]);
  //       return Right(CamExposureOffsets(min: minExpOffset, max: maxExpOffset));
  //     } catch (_) {
  //       return Left("Cannot get Offsets");
  //     }
  //   }
  //   return Left("Camera not initialised");
  // }

  // set exposure offset
  // Future<bool> setExposureOffset(double offset) async {
  //   if (_isControllerInitialised) {
  //     await cameraController.setExposureOffset(offset);
  //     return true;
  //   }
  //   return false;
  // }

  // take photo
  Future<Either<String, String>> takePhoto() async {
    late final String? imagePath;

    await cameraController.takePicture().then((XFile file) {
      imagePath = file.path;
    });

    if (imagePath == null) {
      return const Left('Error taking Photo');
    } else {
      cameraController.pausePreview();

      if (flashMode == FlashMode.torch) {
        cameraController.setFlashMode(FlashMode.off);
      }

      return Right(imagePath!);
    }
  }

  // change exposureMode
  void changeExposureMode() {
    cameraController.setExposureMode(ExposureMode.auto);
  }

  void dispose() {
    cameraController.dispose();
  }
}
