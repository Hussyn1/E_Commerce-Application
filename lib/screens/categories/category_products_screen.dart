import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:ecommerce_fyp/data/models/product_model.dart';
import 'package:ecommerce_fyp/screens/categories/controller/categories_controller.dart';
import 'package:ecommerce_fyp/screens/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get category name and products from arguments
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String categoryName = args['category'] ?? 'All';
    final List<Product> products = args['products'] ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          categoryName,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.iconPrimary),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: AppColors.iconSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try browsing other categories',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            )
          : CustomScrollView(
              slivers: [
                // Product count header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${products.length} ${products.length == 1 ? 'Product' : 'Products'} Found',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                // Products Grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = products[index];
                        final controller = Get.find<CategoriesController>();
                        return ProductCard(
                          product: product,
                          onFavoriteToggle: () => controller.toggleFavorite(product.id),
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
    );
  }
}
