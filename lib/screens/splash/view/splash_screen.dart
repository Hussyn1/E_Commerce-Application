import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:ecommerce_fyp/screens/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        // ignore: unused_local_variable
        final splashcontroller = Get.find<SplashController>(); 
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.5 + (value * 0.5),
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.checkroom,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'FASHION STORE',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.surface,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Try Before You Buy',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textHint,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}