import 'package:ecommerce_fyp/config/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    print("SplashController ONINIT CALLED");
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
