import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/firebase_options.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courseinfo.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courses2.dart';
import 'package:primeway_admin_panel/view/body_panels/course_panel_body.dart';
import 'package:primeway_admin_panel/view/course_dashboard/course_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      home:CoursesPage(),
    );
  }
}
