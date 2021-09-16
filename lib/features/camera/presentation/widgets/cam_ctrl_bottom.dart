import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/camera/presentation/cubit/cam_cubit.dart';
import 'package:notes/features/image_crop/image_crop_screen.dart';

class CamCtrlBottom extends StatelessWidget {
  final double height;
  const CamCtrlBottom({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: BlocListener<CamCubit, CamState>(
        listener: (context, state) {
          if (state is ImageTook) {
            _movetoCropScreen(context, state.imagePath);
          }
        },
        child: Column(
          children: [
            _cameraButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton _cameraButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _takePhoto(context),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const CircleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.amber;
            }
          },
        ),
      ),
      child: const Icon(
        Icons.camera_alt,
      ),
    );
  }

  void _takePhoto(BuildContext context) {
    BlocProvider.of<CamCubit>(context).takePhoto();
  }

  void _movetoCropScreen(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CropPage(imagepath: imagePath),
      ),
    );
  }
}
