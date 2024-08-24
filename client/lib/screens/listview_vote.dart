import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import './wishlist_screen.dart'; // Import the WishlistScreen

class ListViewVote extends StatelessWidget {
  const ListViewVote({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 상품 데이터를 Poll 객체로 변환
    final List<Poll> products = [
      Poll(
        id: '1',
        price: '20.00',
        content: '이거 맛있음?',
        thumbnail: 'https://via.placeholder.com/150',
        coupangUrl: '',
        likes: 150,
        dislikes: 50,
        isVoted: false,
        isLiked: false,
        isDisliked: false,
        comments: [],
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
      Poll(
        id: '2',
        price: '35.00',
        content: '이거 사야할까?',
        thumbnail: 'https://via.placeholder.com/150',
        coupangUrl: '',
        likes: 200,
        dislikes: 100,
        isVoted: false,
        isLiked: false,
        isDisliked: false,
        comments: [],
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
      Poll(
        id: '3',
        price: '50.00',
        content: '이게 제일 좋아요!',
        thumbnail: 'https://via.placeholder.com/150',
        coupangUrl: '',
        likes: 300,
        dislikes: 50,
        isVoted: false,
        isLiked: false,
        isDisliked: false,
        comments: [],
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
      Poll(
        id: '4',
        price: '40.00',
        content: '정말 필요한가요?',
        thumbnail: 'https://via.placeholder.com/150',
        coupangUrl: '',
        likes: 250,
        dislikes: 25,
        isVoted: false,
        isLiked: false,
        isDisliked: false,
        comments: [],
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final poll = products[index];
          return PinkContainer(poll: poll);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to WishlistScreen when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishlistScreen(),
            ),
          );
        },
        child: const Icon(Icons.add), // Icon to display on the FAB
        backgroundColor: Theme.of(context).colorScheme.primary, // Use colorScheme's primary color
      ),
    );
  }
}
