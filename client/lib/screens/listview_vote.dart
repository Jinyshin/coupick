import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import './wishlist_screen.dart'; // Import the WishlistScreen
import '../providers/listview_product_provider.dart'; // Import the product provider

class ListViewVote extends StatelessWidget {
  const ListViewVote({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the getProducts function to get the list of Poll objects
    final List<Poll> products = getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final poll = products[index];
          return Column(
            children: [
              PinkContainer(poll: poll),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // 왼쪽, 오른쪽에 16의 패딩 추가
                child: Divider(
                  thickness: 1, // 두께를 1로 설정
                ),
              ),  // Divider 추가
            ],
          );
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
