import 'package:flutter/material.dart';
import './widgets/pink_container.dart';
import '../models/polls.dart';
import 'package:client/services/getpolls_service.dart'; // Import the GetPollsService
import 'package:client/utilities/logout.dart';
import './widgets/add_post.dart';

class ListViewVote extends StatefulWidget {
  const ListViewVote({super.key});

  @override
  _ListViewVoteState createState() => _ListViewVoteState();
}

class _ListViewVoteState extends State<ListViewVote> {
  late Future<List<Poll>> futurePolls;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    futurePolls = GetPollsService().getPolls(); // Fetch polls from the API
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  Future<void> _reloadPolls() async {
    setState(() {
      futurePolls = GetPollsService().getPolls(); // Reload polls from the API
    });
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
        child: FutureBuilder<List<Poll>>(
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
                controller: _scrollController, // Attach ScrollController to the ListView
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
              );
            }
          },
        ),
      ),
      floatingActionButton: AddPostButton(scrollController: _scrollController), // Pass ScrollController to the button
    );
  }
}
