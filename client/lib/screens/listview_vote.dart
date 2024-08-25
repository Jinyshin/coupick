import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/new_poll_detail_screen.dart';
import 'package:client/screens/poll_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import 'package:client/utilities/logout.dart';
import './wishlist_screen.dart';
import '../providers/pollsprovider.dart';
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

    // Fetch polls after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pollsProvider = Provider.of<PollsProvider>(context, listen: false);
      pollsProvider.fetchPolls(); // Fetch polls using the provider
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  Future<void> _reloadPolls() async {
    final pollsProvider = Provider.of<PollsProvider>(context, listen: false);
    await pollsProvider.fetchPolls(); // Reload polls using the provider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
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
      body: RefreshIndicator(
        onRefresh: _reloadPolls, // Define the function to reload the list
        child: Consumer<PollsProvider>(
          builder: (context, pollsProvider, child) {
            if (pollsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (pollsProvider.hasError) {
              return Center(
                  child: Text('Error: ${pollsProvider.errorMessage}'));
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
                                  NewPollDetailScreen(pollId: poll.id),
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
      ),
      floatingActionButton: AddPostButton(
          scrollController:
              _scrollController), // Pass ScrollController to the button
    );
  }
}
