import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:ecommerce_fyp/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_fyp/screens/home/controller/home_tab_controller.dart';
import 'package:ecommerce_fyp/screens/home/widget/product_card.dart';
import 'package:ecommerce_fyp/screens/product_detail/controller/product_detail_controller.dart';
import 'package:ecommerce_fyp/screens/product_detail/widget/color_selector.dart';
import 'package:ecommerce_fyp/screens/product_detail/widget/image_gallery.dart';
import 'package:ecommerce_fyp/screens/product_detail/widget/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: AppColors.surface,
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.iconPrimary),
                  onPressed: () => Get.back(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: AppColors.iconPrimary),
                    onPressed: () {
                      Get.snackbar(
                        'Share',
                        'Share product functionality',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.iconPrimary,
                        ),
                        onPressed: () => Get.toNamed('/cart'),
                      ),
                      Obx(() {
                        if (cartController.itemCount > 0) {
                          return Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cartController.itemCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                    ],
                  ),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Images Gallery
                      Obx(() => ImageGallery(
                            images: controller.productImages,
                            currentIndex: controller.currentImageIndex.value,
                            onImageChanged: controller.changeImage,
                          )),

                      const SizedBox(height: 24),

                      // Product Name & Price
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.product.value.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.product.value.category,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              controller.product.value.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: controller.product.value.isFavorite
                                  ? Colors.red
                                  : AppColors.iconSecondary,
                            ),
                            onPressed: controller.toggleFavorite,
                          ),
                        ],
                      )),

                      const SizedBox(height: 12),

                      // Rating
                      Obx(() => Row(
                        children: [
                          Icon(Icons.star, size: 20, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            controller.product.value.rating.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${(controller.product.value.rating * 234).toInt()} reviews)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      )),

                      const SizedBox(height: 20),

                      // Price
                      Obx(() => Text(
                        '\$${controller.product.value.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      )),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Size Selector
                      Obx(() => SizeSelector(
                            sizes: controller.availableSizes,
                            selectedSize: controller.selectedSize.value,
                            onSizeSelected: controller.selectSize,
                          )),

                      const SizedBox(height: 24),

                      // Color Selector
                      Obx(() => ColorSelector(
                            colors: controller.availableColors,
                            selectedColor: controller.selectedColor.value,
                            onColorSelected: controller.selectColor,
                          )),

                      const SizedBox(height: 24),

                      // Quantity Selector
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Obx(() => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: controller.decrementQuantity,
                                      icon: const Icon(Icons.remove),
                                      color: AppColors.iconPrimary,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        '${controller.quantity.value}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.incrementQuantity,
                                      icon: const Icon(Icons.add),
                                      color: AppColors.iconPrimary,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() => Text(
                        controller.product.value.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: AppColors.textSecondary,
                        ),
                      )),

                      const SizedBox(height: 24),
                      const Text(
                        'Similar Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.similarProducts.length,
                          itemBuilder: (context, index) {
                            final similarProduct = controller.similarProducts[index];
                            return Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 16),
                              child: ProductCard(
                                product: similarProduct,
                                onFavoriteToggle: () {
                                  final homeController = Get.find<HomeTabController>();
                                  homeController.toggleFavorite(similarProduct.id);
                                  controller.update(); // Refresh UI
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 100), // Space for bottom buttons
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Navigation Bar with Add to Cart
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          cartController.addToCart(controller.product.value);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
    