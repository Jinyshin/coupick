import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/dislike_reaction_screen.dart';
import 'package:client/screens/like_reaction_screen.dart';
import 'package:client/screens/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/providers/pollsprovider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/screens/widgets/product_info_section.dart';
import 'package:client/screens/widgets/reaction_section.dart';

class PollDetailScreen extends StatelessWidget {
  final String pollId;

  const PollDetailScreen({super.key, required this.pollId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Consumer<PollsProvider>(
        builder: (context, pollsProvider, child) {
          final poll = pollsProvider.getPollById(pollId);
          if (poll == null) {
            return const Center(
              child: Text('Poll not found'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ProductInfoSection(
                    content: poll.content,
                    thumbnail: poll.thumbnail,
                    price: poll.price.toString(),
                    coupangUrl: poll.coupangUrl,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: ReactionSection(
                      pollId: poll.id,
                      likes: poll.likes,
                      dislikes: poll.dislikes,
                      comments: poll.comments,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
