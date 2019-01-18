import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _nfcData = 'Unknown';
  bool _nfcReading = false;

  @override
  void initState() {
    super.initState();
    startNFC();
  }

  Future<void> startNFC() async {
    String response;
    bool reading = true;

    try {
      print('Trying to read');
      response = await FlutterNfcReader.read;
      print('RESPONSE: $response');
    } on PlatformException {
      response = '';
      reading = false;
    }
    setState(() {
      _nfcReading = reading;
      _nfcData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text('NFC demo'),),
        body: Center(
          child: Text('NFC Data: \n $_nfcData\n', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
