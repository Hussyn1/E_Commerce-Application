import 'package:ecommerce_fyp/data/models/product_model.dart';
import 'package:ecommerce_fyp/data/services/firestore_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore mockFirestore;
  late FirestoreService firestoreService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(firestore: mockFirestore, auth: mockAuth);
  });

  group('FirestoreService Tests', () {
    test('getProducts should fetch products from Firestore', () async {
      // Seed mock Firestore
      await mockFirestore.collection('products').add({
        'name': 'Test Product',
        'description': 'Description',
        'price': 100.0,
        'image': 'url',
        'category': 'Test',
        'rating': 4.5,
      });

      final products = await firestoreService.getProducts();

      expect(products.length, 1);
      expect(products[0].name, 'Test Product');
      expect(products[0].price, 100.0);
    });

    test('placeOrder should save order to Firestore if user is logged in', () async {
      // Mock log in
      await mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123!',
      );

      final orderItems = [
        {'productId': 'p1', 'name': 'Item 1', 'quantity': 1, 'price': 50.0}
      ];
      const totalAmount = 50.0;

      await firestoreService.placeOrder(
        items: orderItems,
        totalAmount: totalAmount,
      );

      final orders = await mockFirestore.collection('orders').get();
      expect(orders.docs.length, 1);
      expect(orders.docs[0].data()['totalAmount'], totalAmount);
      expect(orders.docs[0].data()['userId'], mockAuth.currentUser?.uid);
    });

    test('placeOrder should throw exception if user is not logged in', () async {
      expect(
        () => firestoreService.placeOrder(items: [], totalAmount: 0),
        throwsException,
      );
    });
  });
}
