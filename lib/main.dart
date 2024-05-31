import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/login_page.dart';
import 'package:m_share/home.dart';
import 'package:m_share/add_material.dart';
import 'package:m_share/setting.dart';
import 'package:m_share/admin_panel.dart';
import 'package:m_share/add_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m_share/course.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M-Share',
      home: LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith('/course/')) {
          final title = settings.name!.substring('/course/'.length);
          return MaterialPageRoute(
            builder: (context) => Course(courseTitle: title),
          );
        }

        // Handle other routes
        switch (settings.name) {
          // case '/home':
          //   return MaterialPageRoute(builder: (context) => const Home());
          case '/addMaterial':
            return MaterialPageRoute(builder: (context) => AddMaterialPage());
          case '/addUser':
            return MaterialPageRoute(builder: (context) => AddUserPage());
          case '/changePassword':
            return MaterialPageRoute(builder: (context) => Setting());
          case '/adminPanel':
            return MaterialPageRoute(builder: (context) => const Admin());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return null;
        }
      },
    );
  }
}
