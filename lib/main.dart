import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes/app_pages.dart';
import 'config/theme/app_theme.dart';

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
      title: 'Ecommerce FYP',
      debugShowCheckedModeBanner: false,

      // Initial Route
      initialRoute: AppPages.INITIAL,

      // All GetX pages
      getPages: AppPages.routes,

      // Apply your custom light theme
      theme: AppTheme.lightTheme,
    );
  }
}
