import 'package:ecommerce_fyp/config/routes/app_routes.dart';
import 'package:ecommerce_fyp/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.signIn(email: email, password: password);
      Get.offAllNamed(AppRoutes.MAIN);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.signUp(name: name, email: email, password: password);
      // After signup, we can navigate to main
      Get.offAllNamed(AppRoutes.MAIN);
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
