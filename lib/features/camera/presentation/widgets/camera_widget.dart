import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/camera/presentation/cubit/cam_cubit.dart';
import 'package:notes/features/camera/presentation/widgets/focus_widget.dart';

class CameraWidget extends StatelessWidget {
  final double width;
  final double height;
  const CameraWidget({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CamCubit, CamState>(
      buildWhen: (previous, context) {
        if (previous is CamInitial) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is CamLoaded) {
          final aspectRatio = context.read<CamCubit>().aspectRatio;
          return SizedBox(
            height: height,
            width: width,
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width,
                height: width * aspectRatio,
                child: CameraPreview(
                  context.read<CamCubit>().camController,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (details) => _onViewFinderTap(
                      details: details,
                      aspectRatio: aspectRatio,
                      width: width,
                      context: context,
                    ),
                    child: BlocBuilder<CamCubit, CamState>(
                      buildWhen: (previous, current) {
                        if (current is CamNewFocus ||
                            current is CamFocusDisappear) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        if (state is CamNewFocus) {
                          return _focusIndicator(state.x, state.y);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: height,
            width: width,
            child: const Center(
              child: Text("Loading..."),
            ),
          );
        }
      },
    );
  }

  // we have x values form 0 to 1
  // y values form 0 to 1
  // however align widget has x and y
  //values form -1 to 1
  Align _focusIndicator(double x1, double y1) {
    final double x = x1 * 2 - 1;
    final double y = y1 * 2 - 1;
    return Align(
      alignment: Alignment(x, y),
      child: const CustomPaint(
        painter: FocusPainter(side: 60),
      ),
    );
  }

  void _onViewFinderTap({
    required TapDownDetails details,
    required double aspectRatio,
    required double width,
    required BuildContext context,
  }) {
    final offset = Offset(
      details.localPosition.dx / width,
      details.localPosition.dy / (aspectRatio * width),
    );

    //debugPrint(offset.toString());
    context.read<CamCubit>().changeFocus(focusOffset: offset);
  }
}
