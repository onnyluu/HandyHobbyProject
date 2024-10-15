import 'package:flutter/material.dart';
import 'screens/login_page.dart';  // import ไฟล์จากโฟลเดอร์ screens

void main() {
  runApp(
    MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handy Hobby',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),  // หน้าล็อคอินเป็นหน้าแรก
    );
  }
}

