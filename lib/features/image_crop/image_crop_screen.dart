import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CropPage extends StatefulWidget {
  final String imagepath;
  const CropPage({
    required this.imagepath,
    Key? key,
  }) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  File? imag;

  @override
  void initState() {
    _readFile();
    // imag = File(widget.imagepath);
    super.initState();
  }

  void _readFile() async {
    final image = File(widget.imagepath);
    final bytes = await image.readAsBytes();
    debugPrint('bytes:' + bytes[4].toString());
    var small = bytes[0];
    for (int i = 0; i < bytes.length; i++) {
      debugPrint(bytes[i].toString());
    }

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final filePath = tempPath + '/img01.tmp';

    final buffer = bytes.buffer;

    final img = await File(filePath).writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    debugPrint(bytes[0].toString());
    imag = img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: imag == null ? Container() : Image.file(imag!),
    );
  }
}
