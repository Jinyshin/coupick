import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import '../utilities/logout.dart';
import '../providers/listview_product_provider.dart';
import './widgets/add_post.dart';

class ListViewVote extends StatelessWidget {
  const ListViewVote({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Poll> products = getProducts();
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupick List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button click (e.g., navigate to notifications screen)
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
        controller: _scrollController,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final poll = products[index];
          return Column(
            children: [
              PinkContainer(poll: poll),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the left and right
                child: Divider(
                  thickness: 1, // Set thickness to 1
                ),
              ), // Add Divider
            ],
          );
        },
      ),
      floatingActionButton: AddPostButton(scrollController: _scrollController),
    );
  }
}
