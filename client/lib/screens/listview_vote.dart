import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import 'package:client/services/getpolls_service.dart'; // Import the GetPollsService

import 'package:client/utilities/logout.dart';
import './wishlist_screen.dart'; // Import the WishlistScreen

class ListViewVote extends StatefulWidget {
  const ListViewVote({super.key});

  @override
  _ListViewVoteState createState() => _ListViewVoteState();
}

class _ListViewVoteState extends State<ListViewVote> {
  late Future<List<Poll>> futurePolls;

  @override
  void initState() {
    super.initState();
    futurePolls = GetPollsService().getPolls(); // Fetch polls from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupick List'),
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
      body: FutureBuilder<List<Poll>>(
        future: futurePolls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No polls available'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
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
                    ), // Divider 추가
                  ],
                );
              },
            );
          }
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
