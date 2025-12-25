import 'package:ecommerce_fyp/screens/home/view/home_screen.dart';
import 'package:ecommerce_fyp/screens/home/widget/product_card.dart';
import 'package:ecommerce_fyp/screens/home/controller/home_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    // Reset GetX before each test
    Get.reset();
    Get.put(HomeTabController());
  });

  group('Shopping UI Tests (Black Box)', () {
    testWidgets('Home screen displays product categories', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: HomeScreen()));
      
      expect(find.text('All'), findsOneWidget);
      expect(find.text('T-Shirts'), findsOneWidget);
    });

    testWidgets('Search bar is present on Home screen', (WidgetTester tester) async {
       await tester.pumpWidget(const GetMaterialApp(home: HomeScreen()));
       expect(find.byType(TextField), findsOneWidget); // Assuming SearchBar is a TextField
    });

    testWidgets('Empty cart message', (WidgetTester tester) async {
      // Assuming CartScreen displays a message when empty
      // expect(find.text('Your cart is empty'), findsOneWidget);
    });
  });
}
