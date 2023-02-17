import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeway_admin_panel/firebase_options.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AdminDashBoard(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.rubik(),
          bodySmall: GoogleFonts.rubik(),
        ),
      ),
      // home: CoursesInfo(),
    );
  }
}
