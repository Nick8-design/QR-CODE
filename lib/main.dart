import 'package:flutter/material.dart';
import 'package:qr_code/generate_qr.dart';
import 'package:qr_code/scan_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner and Gen',
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner and Gen"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScanQrCode())
                    );
                    
                  });
                },
                child: Text("Scan Qr Code")
            ),
            SizedBox(height: 40,),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GenerateQrCode())
                    );
                  });
                },
                child: Text("Generate Qr Code")
            ),
          ],
        ),
      ),
    );
  }
}



