import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/firebase_options.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/approved_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/combo.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/comboscreen.dart';

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
      home: //ComboPage()
          // CoursesCombo() //UploadComboScreen(courseId: 'kuhuk')
          AdminDashBoard(),

      // home: CoursesInfo(),
    );
  }
}
