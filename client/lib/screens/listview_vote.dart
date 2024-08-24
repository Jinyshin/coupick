import 'package:flutter/material.dart';
import './widgets/pink_container.dart';

class ListViewVote extends StatelessWidget {
  const ListViewVote({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 상품 데이터
    final List<Map<String, dynamic>> products = [
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'topic': '이거 맛있음?',
        'price': '\$20.00',
        'likes': 150,
        'dislikes': 50,
        'participants': '276',
        'time': '2:30:32'
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'topic': '이거 사야할까?',
        'price': '\$35.00',
        'likes': 200,
        'dislikes': 100,
        'participants': '320',
        'time': '1:45:10'
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'topic': '이게 제일 좋아요!',
        'price': '\$50.00',
        'likes': 300,
        'dislikes': 50,
        'participants': '180',
        'time': '3:20:50'
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'topic': '정말 필요한가요?',
        'price': '\$40.00',
        'likes': 250,
        'dislikes': 25,
        'participants': '210',
        'time': '0:45:22'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return PinkContainer(
            imageUrl: product['imageUrl']!,
            topic: product['topic']!,
            price: product['price']!,
            likes: product['likes'],
            dislikes: product['dislikes'],
            participants: product['participants']!,
            time: product['time']!,
          );
        },
      ),
    );
  }
}
