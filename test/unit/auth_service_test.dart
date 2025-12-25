import 'package:ecommerce_fyp/data/services/auth_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore mockFirestore;
  late AuthService authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();
    authService = AuthService(auth: mockAuth, firestore: mockFirestore);
  });

  group('AuthService Tests', () {
    test('signUp should create a user and store profile in Firestore', () async {
      const email = 'test@example.com';
      const password = 'Password123!';
      const name = 'Test User';

      final userCredential = await authService.signUp(
        email: email,
        password: password,
        name: name,
      );

      // Verify Auth
      expect(userCredential?.user?.email, email);
      expect(mockAuth.currentUser?.email, email);

      // Verify Firestore
      final userDoc = await mockFirestore
          .collection('users')
          .doc(userCredential!.user!.uid)
          .get();
      
      expect(userDoc.exists, true);
      expect(userDoc.data()?['name'], name);
      expect(userDoc.data()?['email'], email);
    });

    test('signIn should log in an existing user', () async {
      const email = 'test@example.com';
      const password = 'Password123!';
      
      // Pre-create user in mock auth
      await mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userCredential = await authService.signIn(
        email: email,
        password: password,
      );

      expect(userCredential?.user?.email, email);
      expect(mockAuth.currentUser?.email, email);
    });

    test('signOut should log out the current user', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123!',
      );
      
      expect(mockAuth.currentUser, isNotNull);
      
      await authService.signOut();
      
      expect(mockAuth.currentUser, isNull);
    });
  });
}
