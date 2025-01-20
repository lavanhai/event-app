import 'package:event_app/navigator/navigation_bar.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const NavigationBarApp(),
    );
  }
}
