import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_product_provider.dart';
import 'screens/wishlist_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupick App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WishlistScreen(),
    );
  }
}
