import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/camera/presentation/widgets/flash_drop_down.dart';
import 'package:notes/features/camera/presentation/cubit/cam_cubit.dart';

class CamCtrlTop extends StatelessWidget {
  const CamCtrlTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CamCubit, CamState>(
      buildWhen: (previous, current) {
        if (previous is CamInitial) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is CamInitial) {
          return const SizedBox();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlashDropDown(
                  onFlashItemChanged: (FlashMode flashMode) {
                    context.read<CamCubit>().switchFlashMode(flashMode);
                  },
                ),
                TextButton(
                  onPressed: () {
                    // context.read<CamCubit>().setExposureOffset();
                  },
                  child: const Text('exposure'),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
