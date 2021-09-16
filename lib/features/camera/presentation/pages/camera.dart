import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/camera/presentation/widgets/camera_widget.dart';
import 'package:notes/features/camera/presentation/widgets/cam_ctrl_bottom.dart';
import 'package:notes/features/camera/presentation/widgets/cam_ctrl_top.dart';
import 'package:notes/features/camera/presentation/cubit/cam_cubit.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _height = _size.height - _padding.top - _padding.bottom;
    final _reservedHeight = _height * 1 / 5;
    final _containerHeight = _height / 10;

    return BlocProvider<CamCubit>(
      create: (context) => CamCubit(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, _containerHeight),
          child: Container(
            width: double.infinity,
            height: _containerHeight,
            padding: EdgeInsets.only(top: _padding.top),
            color: Colors.black,
            child: const CamCtrlTop(),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            CameraWidget(
              width: _size.width,
              height: _height - _reservedHeight,
            ),
            Container(
              height: _containerHeight,
              width: double.infinity,
              color: Colors.black.withOpacity(.2),
              child: CamCtrlBottom(
                height: _containerHeight,
              ),
            )
          ],
        ),
      ),
    );
  }
}
