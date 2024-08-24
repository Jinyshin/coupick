import 'package:flutter/material.dart';
import 'package:client/screens/dislike_reaction_screen.dart';
import 'package:client/screens/like_reaction_screen.dart';
import 'package:client/screens/widgets/progressbar.dart';
import 'package:client/common/const/app_colors.dart';
import 'package:client/models/polls.dart';

class ReactionSection extends StatefulWidget {
  final String pollId;  // pollId 필드 추가
  final int likes;
  final int dislikes;
  final List<Comment> comments;

  const ReactionSection({
    super.key,
    required this.pollId,  // pollId 필수 인자로 추가
    required this.likes,
    required this.dislikes,
    required this.comments,
  });

  @override
  _ReactionSectionState createState() => _ReactionSectionState();
}

class _ReactionSectionState extends State<ReactionSection> {
  int currentIndex = 0;

  void _onSwipe(bool liked) {
    if (liked) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LikeReactionScreen(pollId: widget.pollId),  // pollId 전달
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisLikeReactionScreen(pollId: widget.pollId),  // pollId 전달
        ),
      );
    }

    setState(() {
      currentIndex++;
    });
  }

  void _showReactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.66,
          minChildSize: 0.2,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Reaction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index) {
                        final comment = widget.comments[index];
                        return ListTile(
                          leading: const Icon(Icons.thumb_down,
                              color: AppColors.yellowLogoColor),
                          title: Text('${comment.name}: ${comment.content}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProgressBar(likes: widget.likes, dislikes: widget.dislikes),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showReactions(context),
          child: const Text(
            'Show all reactions',
            style: TextStyle(color: AppColors.middleGray, fontSize: 20),
          ),
        ),
        const SizedBox(height: 8),
        if (widget.comments.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.thumb_down, color: AppColors.yellowLogoColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.comments[0].content,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        const SizedBox(height: 56),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                gradient: SweepGradient(
                  colors: [Colors.red, Colors.blue, Colors.green, Colors.red],
                  stops: [0.0, 0.5, 0.75, 1.0],
                ),
              ),
              child: Center(
                child: Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_down,
                        color: Colors.white, size: 48),
                    onPressed: () => _onSwipe(false),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 90),
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                gradient: SweepGradient(
                  colors: [Colors.red, Colors.blue, Colors.green, Colors.red],
                  stops: [0.0, 0.5, 0.75, 1.0],
                ),
              ),
              child: Center(
                child: Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up,
                        color: Colors.white, size: 48),
                    onPressed: () => _onSwipe(true),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
