// import your app colors
import 'package:client/common/const/app_colors.dart';
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
    double likePercentage = totalVotes > 0 ? likes / totalVotes : 0.0;

    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.thumb_down,
              color: dislikePercentage > 0.5
                  ? AppColors.yellowLogoColor
                  : AppColors.yellowLogoColor.withOpacity(0.2), // 흐리게
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 12.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: dislikePercentage > 0.5
                      ? LinearProgressIndicator(
                    value: dislikePercentage,
                    backgroundColor: AppColors.lightblueLogoColor.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.yellowLogoColor),
                  )
                      : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0),
                    child: LinearProgressIndicator(
                      value: likePercentage,
                      backgroundColor: AppColors.yellowLogoColor.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.lightblueLogoColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.thumb_up,
              color: likePercentage > 0.5
                  ? AppColors.lightblueLogoColor
                  : AppColors.lightblueLogoColor.withOpacity(0.2), // 흐리게
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
