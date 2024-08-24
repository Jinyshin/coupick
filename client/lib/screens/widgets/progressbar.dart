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
    double dislikePercentage = totalVotes > 0 ? dislikes / totalVotes : 0.0;

    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.thumb_down,
              color: Colors.red,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SizedBox(
                height: 12.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: LinearProgressIndicator(
                    value: dislikePercentage,
                    backgroundColor: Colors.green.withOpacity(0.5),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
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
