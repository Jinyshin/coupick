import 'package:client/screens/voting_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_product_provider.dart';
import 'screens/wishlist_screen.dart';
import 'screens/listview_vote.dart';

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
      title: 'coupick',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ListViewVote(),
    );
  }
}
