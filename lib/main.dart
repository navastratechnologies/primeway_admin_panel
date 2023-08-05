import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:primeway_admin_panel/firebase_options.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/affiliate_dashboard_panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  bool loggedIn = false;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: loggedIn ? const AdminDashBoard() : const LoginPage(),
      home: AffiliateDashboard(),
    );
  }

  checkLogin() async {
    log('username is ${box.read('username')}');
    if (box.read('username') == null) {
      setState(() {
        loggedIn = false;
      });
    } else {
      setState(() {
        loggedIn = true;
      });
    }
  }
}
