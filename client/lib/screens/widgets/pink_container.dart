import 'package:flutter/material.dart';
import 'progressbar.dart';
import 'package:client/utilities/calculate_vote.dart';
import 'package:client/models/polls.dart';
import 'package:client/common/const/app_colors.dart';
import '../widgets/timer.dart';

class PinkContainer extends StatelessWidget {
  final Poll poll;

  const PinkContainer({
    super.key,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Left Column: Image and Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          poll.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                    ),
                  //   const SizedBox(height: 8),
                  //   Row(
                  //     children: [
                  //       Text(
                  //         poll.price,
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       SizedBox(width: 5,),
                  //       Text(
                  //         '원',
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                   ],
                ),
                const SizedBox(width: 16),
                // Right Column: Time, Topic
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '투표 마감까지',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 5),
                          CountdownTimer(endTime: poll.createdAt.add(Duration(hours: 24))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        poll.content,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ProgressBar(likes: poll.likes, dislikes: poll.dislikes), // ProgressBar 위젯 사용
          ],
        ),
      ),
    );
  }
}
