import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/login_page.dart';
import 'package:m_share/home.dart';
import 'Package:m_share/add_material.dart';
import 'package:m_share/setting.dart';
import 'package:m_share/admin_panel.dart';
import 'package:m_share/add_user.dart';
import 'package:firebase_core/firebase_core.dart';

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
      routes: {
        '/home': (context) => const Home(),
        '/addMaterial': (context) => const AddMaterialPage(),
        '/addUser': (context) => const AddUserPage(),
        '/changePassword': (context) => const Setting(),
        '/adminPanel': (context) => const Admin(),
      },
    );
  }
}
