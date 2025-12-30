import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';


class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _GenerateQrCodeState();
}



class _GenerateQrCodeState extends State<ScanQrCode> {
  String displayData = "Nothing scanned yet";
  String? rawValue;
  MobileScannerController controller = MobileScannerController();

  Future<void> _scanFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // 1. Capture the result as BarcodeCapture? instead of bool
      final BarcodeCapture? capture = await controller.analyzeImage(image.path);

      // 2. Check if capture is null or barcodes list is empty
      if (capture == null || capture.barcodes.isEmpty) {
        setState(() {
          displayData = "No QR code found in this image.";
          rawValue = null;
        });
      } else {
        // 3. Extract the data if successful
        final Barcode barcode = capture.barcodes.first;
        setState(() {
          rawValue = barcode.rawValue;
          displayData = rawValue ?? "Unknown data";
        });

        // Optional: Automatically trigger the action if a link is found
        if (rawValue != null) {
          _handleAction(rawValue!);
        }
      }
    }
  }

  Future<void> _handleAction(String data) async {
    final Uri? uri = Uri.tryParse(data);

    // Check if it's a URL
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
    // Check if it's a Wi-Fi QR (Format: WIFI:S:Name;T:WPA;P:Password;;)
    else if (data.startsWith("WIFI:")) {
      _showInfoDialog("Wi-Fi Detected", data.replaceAll("WIFI:", ""));
    }
    else {
      _showInfoDialog("Scanned Content", data);
    }
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart QR Scanner"),
        actions: [
          IconButton(icon: const Icon(Icons.photo_library), onPressed: _scanFromGallery),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  setState(() {
                    rawValue = barcodes.first.rawValue;
                    displayData = rawValue ?? "Unknown data";
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(displayData, textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  if (rawValue != null)
                    ElevatedButton.icon(
                      onPressed: () => _handleAction(rawValue!),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text("Open / Perform Action"),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}