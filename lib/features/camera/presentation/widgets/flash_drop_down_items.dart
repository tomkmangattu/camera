import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashItem {
  final String name;
  final IconData icon;
  final int index;
  final FlashMode flashMode;

  const FlashItem({
    required this.name,
    required this.icon,
    required this.index,
    required this.flashMode,
  });
}
