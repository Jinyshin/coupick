import 'package:client/screens/voting_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_product_provider.dart';
import 'providers/shared_preference_service.dart'; // SharedPreferenceService 가져오기
import 'screens/wishlist_screen.dart';
import 'screens/listview_vote.dart';
import 'screens/signup.dart';

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
    final sharedPreferenceService = SharedPreferenceService();

    return FutureBuilder<bool>(
      future: sharedPreferenceService.hasToken(), // 토큰 확인 함수 사용
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 로딩 중인 경우
        } else {
          bool hasToken = snapshot.data ?? false; // 토큰 존재 여부
          return MaterialApp(
            title: 'Coupick App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: hasToken ? const ListViewVote() : const UsernameCreationScreen(),
            routes: {
              '/vote': (context) => const ListViewVote(),
              '/create-username': (context) => const UsernameCreationScreen(),
            },
          );
        }
      },
    );
  }
}
