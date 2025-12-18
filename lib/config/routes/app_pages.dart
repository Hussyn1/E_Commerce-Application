import 'package:ecommerce_fyp/screens/auth/login/login_screen.dart';
import 'package:ecommerce_fyp/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce_fyp/screens/auth/signup/signup_screen.dart';
import 'package:ecommerce_fyp/screens/cart/cart_screen.dart';
import 'package:ecommerce_fyp/screens/categories/category_products_screen.dart';
import 'package:ecommerce_fyp/screens/home/view/home_screen.dart';
import 'package:ecommerce_fyp/screens/main/binding/main_binding.dart';
import 'package:ecommerce_fyp/screens/main/main_screen.dart';
import 'package:ecommerce_fyp/screens/product_detail/product_detail_screen.dart';
import 'package:ecommerce_fyp/screens/profile/edit_profile_screen.dart';
import 'package:ecommerce_fyp/screens/profile/profile_screen.dart';
import 'package:ecommerce_fyp/screens/profile/wishlist_screen.dart';
import 'package:ecommerce_fyp/screens/splash/binding/splash_binding.dart';
import 'package:ecommerce_fyp/screens/splash/view/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => const SignupScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => const ProductDetailScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.CATEGORY_PRODUCTS,
      page: () => const CategoryProductsScreen(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.WISHLIST,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordScreen(),
    ),
  ];
}
