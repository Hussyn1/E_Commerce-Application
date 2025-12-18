import 'package:ecommerce_fyp/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_fyp/screens/categories/controller/categories_controller.dart';
import 'package:ecommerce_fyp/screens/home/controller/home_tab_controller.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class ProductDetailController extends GetxController {
  late Rx<Product> product;
  
  final selectedSize = ''.obs;
  final selectedColor = ''.obs;
  final quantity = 1.obs;
  final currentImageIndex = 0.obs;
  
  final availableSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final availableColors = [
    {'name': 'Black', 'hex': '0xFF000000'},
    {'name': 'White', 'hex': '0xFFFFFFFF'},
    {'name': 'Navy', 'hex': '0xFF001F3F'},
    {'name': 'Gray', 'hex': '0xFF808080'},
  ];
  
  // Mock additional images for gallery
  final productImages = <String>[].obs;

  List<Product> get similarProducts {
    final homeController = Get.find<HomeTabController>();
    return homeController.products
        .where((p) => p.category == product.value.category && p.id != product.value.id)
        .take(5)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    
    // Get product from arguments
    if (Get.arguments != null && Get.arguments is Product) {
      product = (Get.arguments as Product).obs;
    } else {
      // Fallback or error handling to prevent null check errors
      product = Product(
        id: '0',
        name: 'Product Details',
        description: 'No description available',
        price: 0.0,
        image: '',
        category: 'Unknown',
        rating: 0.0,
      ).obs;
    }

    // Set default selections if product is valid
    if (product.value.id != '0') {
      selectedSize.value = availableSizes[2]; // Default to M
      selectedColor.value = availableColors[0]['name'] as String;
      
      // Initialize image gallery (mock multiple images)
      productImages.value = [
        product.value.image,
        product.value.image,
        product.value.image,
      ];
    }
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(String color) {
    selectedColor.value = color;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void toggleFavorite() {
    product.value = product.value.copyWith(
      isFavorite: !product.value.isFavorite,
    );
    
    // Optionally update other controllers if they exist
    try {
      if (Get.isRegistered<HomeTabController>()) {
        Get.find<HomeTabController>().toggleFavorite(product.value.id);
      }
      if (Get.isRegistered<CategoriesController>()) {
        Get.find<CategoriesController>().toggleFavorite(product.value.id);
      }
    } catch (e) {
      // Ignore if controllers aren't registered
    }
  }

  void addToCart() {
    // Import cart controller
    try {
      final cartController = Get.find<CartController>();
      cartController.addToCart(product.value);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not add to cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
