import 'package:flutter/material.dart';
import 'package:notes/features/camera/presentation/pages/camera.dart';
import 'package:notes/home/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(
        child: HomeDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _movetoCameraPage(context),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }

  void _movetoCameraPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );
  }
}
