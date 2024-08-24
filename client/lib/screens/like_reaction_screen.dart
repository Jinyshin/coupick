import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/widgets/custom_elevated_button.dart';
import 'package:client/services/like_service.dart';
import 'package:flutter/material.dart';

class LikeReactionScreen extends StatelessWidget {
  final String pollId;

  const LikeReactionScreen({super.key, required this.pollId});

  Future<void> _submitReaction(BuildContext context, {String? comment}) async {
    final likeService = LikeService();

    try {
      final success = await likeService.submitLike(pollId, true, comment: comment);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reaction submitted successfully!')),
        );
        Navigator.pop(context); // 성공 후 이전 화면으로 돌아가기
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddedWidth = screenWidth - 32.0;
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Icon(
                      Icons.thumb_up,
                      size: 80,
                      color: AppColors.yellowLogoColor,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Why do you LIKE this?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '(so curious 👀)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: commentController,
                      style: const TextStyle(color: AppColors.black),
                      decoration: const InputDecoration(
                        hintText: 'Type your opinion',
                        hintStyle: TextStyle(color: AppColors.lightGray),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    width: paddedWidth * 0.47,
                    text: 'Skip',
                    textColor: AppColors.darkGray,
                    backgroundColor: AppColors.faintGray,
                    onPressed: () async {
                      _submitReaction(context); // 댓글 없이 전송
                      Navigator.pop(context, true);
                    },
                  ),
                  CustomElevatedButton(
                    width: paddedWidth * 0.47,
                    text: 'Done',
                    textColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () async {
                      _submitReaction(context, comment: commentController.text);
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
