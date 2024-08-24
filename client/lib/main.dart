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
      title: 'Coupick App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListViewVote(), // 여기서 ListViewVote 화면을 표시하도록 설정
    );
  }
}
