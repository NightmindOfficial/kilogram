import 'package:flutter/material.dart';
import 'package:kilogram/layout/mobile_screen_layout.dart';
import 'package:kilogram/layout/responsive_layout_screen.dart';
import 'package:kilogram/layout/web_screen_layout.dart';
import 'package:kilogram/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      title: 'Kilogram',
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
