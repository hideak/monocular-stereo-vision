import 'package:flutter/material.dart';
import './widgets/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Monocular Stereo Vision';
  final String socketIP = 'http://192.168.0.13';
  final int socketPort = 3000;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(appTitle, socketIP, socketPort),
    );
  }
}
