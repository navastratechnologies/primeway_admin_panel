import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courses2.dart';
import 'package:primeway_admin_panel/view/body_panels/course_panel_body.dart';
import 'package:primeway_admin_panel/view/course_dashboard/course_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBptZzJ5pzf26E5iEDGoL2Lr1SZpRXmXcM",
      authDomain: "primeway-fa5e5.firebaseapp.com",
      projectId: "primeway-fa5e5",
      storageBucket: "primeway-fa5e5.appspot.com",
      messagingSenderId: "782580474549",
      appId: "1:782580474549:web:5398232848943852b7d4fc",
      measurementId: "G-TM1G56MF74",
    ),
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseDashboard(),
    );
  }
}
