import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:ecommerce_fyp/screens/home/controller/home_tab_controller.dart';
import 'package:ecommerce_fyp/screens/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeTabController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Wishlist', style: TextStyle(color: AppColors.textPrimary)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final wishlistItems = controller.wishlistProducts;

        if (wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: AppColors.iconSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your wishlist is empty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Go back to shopping'),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            final product = wishlistItems[index];
            return ProductCard(
              product: product,
              onFavoriteToggle: () => controller.toggleFavorite(product.id),
            );
          },
        );
      }),
    );
  }
}
