import 'package:ecommerce_fyp/data/models/product_model.dart';
import 'package:ecommerce_fyp/data/services/firestore_service.dart';
import 'package:ecommerce_fyp/screens/cart/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore mockFirestore;
  late FirestoreService firestoreService;
  late CartController cartController;
  late Product testProduct;

  setUp(() {
    Get.testMode = true;
    mockAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(firestore: mockFirestore, auth: mockAuth);
    cartController = CartController(firestoreService: firestoreService);
    
    testProduct = Product(
      id: 'p1',
      name: 'Test Product',
      description: 'Description',
      price: 100.0,
      image: 'url',
      category: 'Test',
      rating: 4.5,
    );
  });

  group('CartController Tests', () {
    test('addToCart should add item to cart', () {
      cartController.addToCart(testProduct);
      
      expect(cartController.cartItems.length, 1);
      expect(cartController.cartItems[0].product.id, 'p1');
      expect(cartController.cartItems[0].quantity, 1);
    });

    test('incrementQuantity should increase quantity', () {
      cartController.addToCart(testProduct);
      cartController.incrementQuantity('p1');
      
      expect(cartController.cartItems[0].quantity, 2);
      expect(cartController.subtotal, 200.0);
    });

    test('decrementQuantity should decrease quantity or remove item', () {
      cartController.addToCart(testProduct);
      cartController.incrementQuantity('p1');
      cartController.decrementQuantity('p1');
      expect(cartController.cartItems[0].quantity, 1);
      
      cartController.decrementQuantity('p1');
      expect(cartController.cartItems.isEmpty, true);
    });

    test('total should include tax and shipping', () {
      cartController.addToCart(testProduct);
      
      // subtotal 100, tax 10, shipping 5.99
      expect(cartController.total, 115.99);
    });

    test('clearCart should remove all items', () {
      cartController.addToCart(testProduct);
      cartController.clearCart();
      expect(cartController.cartItems.isEmpty, true);
    });
    
    test('checkout should place order in Firestore', () async {
      // Mock login
      await mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com', 
        password: 'Password123!'
      );
      
      cartController.addToCart(testProduct);
      
      await cartController.checkout();
      
      // Verify cart is cleared
      expect(cartController.cartItems.isEmpty, true);
      
      // Verify order in Firestore
      final orders = await mockFirestore.collection('orders').get();
      expect(orders.docs.length, 1);
      expect(orders.docs[0].data()['totalAmount'], 115.99);
    });
  });
}
