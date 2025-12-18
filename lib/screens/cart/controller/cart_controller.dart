import 'package:get/get.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;

  // Computed properties
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * 0.1; // 10% tax

  double get shipping => cartItems.isEmpty ? 0.0 : 5.99;

  double get total => subtotal + tax + shipping;

  // Add product to cart
  void addToCart(Product product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }

    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Remove product from cart
  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  // Update quantity
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      cartItems[index].quantity = newQuantity;
      cartItems.refresh();
    }
  }

  // Increment quantity
  void incrementQuantity(String productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  // Decrement quantity
  void decrementQuantity(String productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        removeFromCart(productId);
      }
    }
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }

  // Checkout
  void checkout() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Cart Empty',
        'Please add items to your cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Implement checkout logic
    Get.snackbar(
      'Checkout',
      'Processing order of \$${total.toStringAsFixed(2)}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
