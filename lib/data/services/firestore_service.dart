import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fyp/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirestoreService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // Products
  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Orders
  Future<void> placeOrder({
    required List<Map<String, dynamic>> items,
    required double totalAmount,
  }) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      await _firestore.collection('orders').add({
        'userId': uid,
        'items': items,
        'totalAmount': totalAmount,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Helper to seed products (useful for the user initially)
  Future<void> seedProducts(List<Product> products) async {
    for (var product in products) {
      await _firestore.collection('products').add(product.toMap());
    }
  }
}
