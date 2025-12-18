import 'package:ecommerce_fyp/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTabController extends GetxController {
  final userName = 'Hussain'.obs;
  final userEmail = 'hussain@gmail.com'.obs;
  final userPhone = '+1 234 567 8900'.obs;

  void updateProfile({required String name, required String email, required String phone}) {
    userName.value = name;
    userEmail.value = email;
    userPhone.value = phone;
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close dialog
        Get.offAllNamed(AppRoutes.LOGIN);
      },
    );
  }
}