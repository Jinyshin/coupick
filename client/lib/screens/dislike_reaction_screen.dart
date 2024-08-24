import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class DisLikeReactionScreen extends StatelessWidget {
  const DisLikeReactionScreen({super.key});

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
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Icon(
                      Icons.thumb_up,
                      size: 80,
                      color: AppColors.yellowLogoColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Why do you DISLIKE this?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(be gentle to avoid hurting feelings 🙏)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
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
            ),
          ],
        ),
      ),
    );
  }
}
