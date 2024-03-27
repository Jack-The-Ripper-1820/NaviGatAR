import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:frontend/path/createPath.dart';
import 'package:frontend/screens/museum_owner.dart';
import 'package:frontend/screens/owner_profile.dart';
import 'package:frontend/screens/qr_gen.dart';
import 'package:frontend/screens/qr_scan.dart';

import 'models/Museum.dart';
import 'theme.dart';
import 'constants.dart';
import 'routes.dart';
import 'package:hive/hive.dart';
import 'screens/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // await Hive.initFlutter();
  // Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  var box = await Hive.openBox("user");
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  static const String _title = 'AR Plugin Demo';

  @override

  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void testConn() async {
    var res = await dio.get("https://203d-117-205-142-162.ngrok.io");
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: const SplashScreen(),
      routes: routes,
    );
  }
}