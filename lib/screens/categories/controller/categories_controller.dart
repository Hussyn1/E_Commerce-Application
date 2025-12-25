import 'package:ecommerce_fyp/data/services/firestore_service.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class CategoryData {
  final String name;
  final String icon;
  final String description;
  int productCount;

  CategoryData({
    required this.name,
    required this.icon,
    required this.description,
    required this.productCount,
  });
}

class CategoriesController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final selectedCategory = ''.obs;
  final products = <Product>[].obs;
  final isLoading = false.obs;
  
  final categories = <CategoryData>[
    CategoryData(
      name: 'T-Shirts',
      icon: '👕',
      description: 'Casual & comfortable',
      productCount: 0,
    ),
    CategoryData(
      name: 'Shirts',
      icon: '👔',
      description: 'Formal & casual',
      productCount: 0,
    ),
    CategoryData(
      name: 'Jeans',
      icon: '👖',
      description: 'Denim collection',
      productCount: 0,
    ),
    CategoryData(
      name: 'Jackets',
      icon: '🧥',
      description: 'Outerwear styles',
      productCount: 0,
    ),
    CategoryData(
      name: 'Shoes',
      icon: '👟',
      description: 'Footwear collection',
      productCount: 0,
    ),
    CategoryData(
      name: 'Accessories',
      icon: '🎒',
      description: 'Bags & more',
      productCount: 0,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      final fetchedProducts = await _firestoreService.getProducts();
      products.value = fetchedProducts;
      updateProductCounts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateProductCounts() {
    for (var category in categories) {
      category.productCount = products.where((p) => p.category == category.name).length;
    }
  }

  void selectCategory(String categoryName) {
    selectedCategory.value = categoryName;
    
    // Get products for this category
    final categoryProducts = getProductsByCategory(categoryName);
    
    // Navigate to category products screen
    Get.toNamed('/category-products', arguments: {
      'category': categoryName,
      'products': categoryProducts,
    });
  }

  List<Product> getProductsByCategory(String categoryName) {
    return products.where((p) => p.category == categoryName).toList();
  }

  void toggleFavorite(String productId) {
    final index = products.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      products[index] = products[index].copyWith(
        isFavorite: !products[index].isFavorite,
      );
      products.refresh();
    }
  }
}
