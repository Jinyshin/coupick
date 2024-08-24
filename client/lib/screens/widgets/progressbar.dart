import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int likes;
  final int dislikes;

  const ProgressBar({
    super.key,
    required this.likes,
    required this.dislikes,
  });

  @override
  Widget build(BuildContext context) {
    int totalVotes = likes + dislikes;
    double likePercentage = totalVotes > 0 ? likes / totalVotes : 0.0;

    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.thumb_down,
              color: Colors.red,
            ),
            Expanded(
              child: LinearProgressIndicator(
                value: likePercentage,
                backgroundColor: Colors.red.withOpacity(0.5),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            const Icon(
              Icons.thumb_up,
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '$totalVotes명의 사람들이 투표 참여중!',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
