import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes/app_pages.dart';
import 'config/theme/app_theme.dart';   // <-- Import your custom theme
//

void main() {
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
