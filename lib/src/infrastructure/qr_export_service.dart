import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QrExportService {
  Future<Uint8List> capture(RenderRepaintBoundary boundary) async {
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw StateError('Could not render QR image.');
    }
    return byteData.buffer.asUint8List();
  }

  Future<File> writeTempPng(Uint8List pngBytes, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    return file.writeAsBytes(pngBytes, flush: true);
  }

  Future<void> saveToGallery(File file) async {
    await Gal.putImage(file.path);
  }

  Future<void> share(File file, {String? text}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: text ?? 'Scan this QR code.',
      ),
    );
  }
}
