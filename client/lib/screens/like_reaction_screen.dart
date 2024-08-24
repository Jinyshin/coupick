import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class LikeReactionScreen extends StatelessWidget {
  const LikeReactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddedWidth = screenWidth - 32.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            const TextField(
              style: TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                hintText: '의견 입력하기',
                hintStyle: TextStyle(color: AppColors.lightGray),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  width: paddedWidth * 0.47,
                  text: 'Skip',
                  textColor: AppColors.darkGray,
                  backgroundColor: AppColors.faintGray,
                  onPressed: () {},
                ),
                CustomElevatedButton(
                  width: paddedWidth * 0.47,
                  text: 'Done',
                  textColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
