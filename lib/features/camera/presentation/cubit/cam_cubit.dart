import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import '../../logic/domain/camera_logic.dart';

part 'cam_state.dart';

class CamCubit extends Cubit<CamState> {
  late final CamLogic _camLogic;

  CamCubit() : super(CamInitial()) {
    _init();
  }

  Future _init() async {
    _camLogic = CamLogic();
    final bool status = await _camLogic.initCam();
    if (status) {
      emit(CamLoaded());
    } else {
      emit(CamError(message: 'Failed to initialise Camera'));
    }
    // _setStatusBarIconColor();
  }

  // set status bar icon color to white
  // void _setStatusBarIconColor() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // }

  // get min and max exposures
  // Future getExposureOffset() async {
  //   final status = await _camLogic.getOffsets();
  //   if (status.isRight) {
  //     emit(ExposureLoaded());
  //   } else {
  //     emit(CamExposureError(message: status.left));
  //   }
  // }

  // change flash mode
  Future switchFlashMode(FlashMode flashMode) async {
    final status = await _camLogic.switchFlashMode(flashMode);
    if (!status) {
      emit(CamFlashError(message: "Error changing flash mode"));
    }
  }

  Future<void> changeFocus({
    required Offset focusOffset,
  }) async {
    _camLogic.changeFocus(focusOffset);
    emit(CamNewFocus(x: focusOffset.dx, y: focusOffset.dy));
    await Future.delayed(const Duration(seconds: 2));
    emit(CamFocusDisappear());
  }

  // change exposure
  // Future<void> setExposureOffset(double offset) async {
  //   final status = await _camLogic.setExposureOffset(offset);
  //   if (!status) {
  //     emit(CamExposureError(message: "Error changing Exposure"));
  //   }
  // }

  Future<void> takePhoto() async {
    final result = await _camLogic.takePhoto();
    if (result.isRight) {
      final String imagePath = result.right;
      emit(ImageTook(imagePath: imagePath));
    } else {
      emit(CamError(message: 'Cannot take photo'));
    }
  }

  // get cam controller
  CameraController get camController {
    return _camLogic.cameraController;
  }

  //get AspectRatio
  double get aspectRatio {
    return _camLogic.cameraController.value.aspectRatio;
  }

  @override
  Future<void> close() {
    _camLogic.dispose();
    return super.close();
  }
}
