import 'package:flutter/material.dart';
import 'package:client/common/const/app_colors.dart'; // Import your app colors

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
                  : AppColors.extraLightGray, // 흐리게
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Stack(
                alignment: Alignment.center, // 텍스트를 중앙에 정렬
                children: [
                  SizedBox(
                    height: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: dislikePercentage > 0.5
                          ? LinearProgressIndicator(
                        value: dislikePercentage,
                        backgroundColor: AppColors.extraLightGray,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.yellowLogoColor),
                      )
                          : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0),
                        child: LinearProgressIndicator(
                          value: likePercentage,
                          backgroundColor: AppColors.extraLightGray,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.lightblueLogoColor),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${(dislikePercentage * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${(likePercentage * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.thumb_up,
              color: likePercentage > 0.5
                  ? AppColors.lightblueLogoColor
                  : AppColors.extraLightGray, // 흐리게
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '$totalVotes people have joined!',
          style: const TextStyle(fontSize: 14, color: AppColors.middleGray),
        ),
      ],
    );
  }
}