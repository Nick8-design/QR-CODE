import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  TextEditingController urlController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  
  Future<void> _shareQrCode() async{
    final image  = await screenshotController.capture();
    
    if(image!=null){
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/qr_code.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([XFile(imagePath.path)], text: 'Scan the Qr code for more information ');
    }
  }

  Future<void> _saveToGallery() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/qr_save.png').create();
      await imagePath.writeAsBytes(image);

      await Gal.putImage(imagePath.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved to Gallery!")),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text("Generate QR Code"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if(urlController.text.isNotEmpty)
        Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white, // Ensures background isn't transparent
                padding: const EdgeInsets.all(10),
                child: QrImageView(
                  data: urlController.text,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _shareQrCode, icon: const Icon(Icons.share)),
                IconButton(onPressed: _saveToGallery, icon: const Icon(Icons.download)),
              ],
            )
          ],
        ),
    SizedBox(height: 18,),
    Container(
    padding: EdgeInsets.only(
    left: 10,
    right: 10
    ),
    child: TextField(


    controller: urlController,
      decoration: InputDecoration(
        hintText: 'Enter your data',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),

    ),
labelText: 'Enter your data',
    )
    ),),
      SizedBox(height: 18),
      ElevatedButton(onPressed: (){
        setState(() {

        });
      },
          child: Text("Generate Qr Code"))


    ])
      )


      ),
    );
  }
}
