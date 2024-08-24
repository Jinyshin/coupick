import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/poll_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider import
import './widgets/pink_container.dart';
import '../models/polls.dart';
import 'package:client/utilities/logout.dart';
import './wishlist_screen.dart';
import '../providers/pollsprovider.dart'; // PollsProvider import
import './widgets/add_post.dart';

class ListViewVote extends StatefulWidget {
  const ListViewVote({super.key});

  @override
  _ListViewVoteState createState() => _ListViewVoteState();
}

class _ListViewVoteState extends State<ListViewVote> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Fetch polls when the widget is initialized
    final pollsProvider = Provider.of<PollsProvider>(context, listen: false);
    pollsProvider.fetchPolls(); // Fetch polls using the provider
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController 폐기
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('coupicks'),
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
      body: Consumer<PollsProvider>(
        builder: (context, pollsProvider, child) {
          if (pollsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (pollsProvider.hasError) {
            return Center(child: Text('Error: ${pollsProvider.errorMessage}'));
          } else if (pollsProvider.polls.isEmpty) {
            return const Center(child: Text('No polls available'));
          } else {
            final products = pollsProvider.polls;
            return ListView.builder(
              controller: _scrollController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final poll = products[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // PollDetailScreen으로 네비게이트, pollId 전달
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PollDetailScreen(pollId: poll.id),
                          ),
                        );
                      },
                      child: PinkContainer(poll: poll),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0), // 왼쪽, 오른쪽에 16의 패딩 추가
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
      floatingActionButton: AddPostButton(scrollController: _scrollController),
    );
  }
}
