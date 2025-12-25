import 'package:ecommerce_fyp/data/mock_data.dart';
import 'package:ecommerce_fyp/data/services/firestore_service.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class HomeTabController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final selectedCategory = 'All'.obs;
  final isLoading = false.obs;
  final products = <Product>[].obs;
  final featuredProducts = <Product>[].obs;

  final categories = ['All', 'T-Shirts', 'Shirts', 'Jeans', 'Jackets', 'Shoes'];

  int get wishlistCount => products.where((p) => p.isFavorite).length;

  List<Product> get wishlistProducts => products.where((p) => p.isFavorite).toList();

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      final fetchedProducts = await _firestoreService.getProducts();
      
      // If Firestore is empty, seed it with mock data
      if (fetchedProducts.isEmpty) {
        await _firestoreService.seedProducts(MockData.getProducts());
        // Reload after seeding
        final newProducts = await _firestoreService.getProducts();
        products.value = newProducts;
      } else {
        products.value = fetchedProducts;
      }
      
      featuredProducts.value = products.take(4).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void toggleFavorite(String productId) {
    final index = products.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      products[index] = products[index].copyWith(
        isFavorite: !products[index].isFavorite,
      );
      products.refresh();
      
      // Update featured products too if needed
      final featuredIndex = featuredProducts.indexWhere((p) => p.id == productId);
      if (featuredIndex >= 0) {
        featuredProducts[featuredIndex] = products[index];
        featuredProducts.refresh();
      }
    }
  }

  List<Product> get filteredProducts {
    if (selectedCategory.value == 'All') {
      return products;
    }
    return products.where((p) => p.category == selectedCategory.value).toList();
  }
}
