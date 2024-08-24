import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/poll_detail_screen.dart';
import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';

import 'package:client/utilities/logout.dart';

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
        title: const Text('coupicks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 알림 버튼 클릭 시 처리할 로직 (예: 알림 화면으로 이동)
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final poll = products[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  // 각 아이템의 id 값을 사용하여 VotingDetailScreen으로 네비게이션
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PollDetailScreen(pollId: poll.id),
                    ),
                  );
                },
                child: PinkContainer(poll: poll),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
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
        }, // Icon to display on the FAB
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add), // Use colorScheme's primary color
      ),
    );
  }
}
