import 'package:client/common/const/app_colors.dart';
import 'package:client/screens/dislike_reaction_screen.dart';
import 'package:client/screens/like_reaction_screen.dart';
import 'package:client/screens/widgets/progressbar.dart';
import 'package:flutter/material.dart';

class PollDetailScreen extends StatelessWidget {
  const PollDetailScreen({super.key, required String pollId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: _ProductInfoSection(),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: _ReactionSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductInfoSection extends StatefulWidget {
  @override
  _ProductInfoSectionState createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<_ProductInfoSection> {
  // TODO: 서버에서 받아오기
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'What do you think of this ROKA T-shirt? I want to be a cool girl',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenWidth,
                    child: Image.asset(
                      'assets/images/roka.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? AppColors.redAccentColor
                            : AppColors.lightGray,
                        size: 30.0,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (isFavorite) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to wishlist.')),
                          );
                        } else {
                          // TODO: 찜 목록에서 제거
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '￦ 18,000',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Row(
                  children: [
                    Text(
                      'more info',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReactionSection extends StatefulWidget {
  @override
  _ReactionSectionState createState() => _ReactionSectionState();
}

class _ReactionSectionState extends State<_ReactionSection> {
  int currentIndex = 0;

  void _onSwipe(bool liked) {
    if (liked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LikeReactionScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DisLikeReactionScreen()),
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
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.thumb_down,
                              color: AppColors.yellowLogoColor),
                          title: Text('This is the reaction of user $index'),
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
        const ProgressBar(likes: 80, dislikes: 20),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showReactions(context),
          child: const Text(
            'Show all reactions',
            style: TextStyle(color: AppColors.middleGray, fontSize: 20),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.thumb_down, color: AppColors.yellowLogoColor),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "It's ugly...",
                style: TextStyle(color: Colors.black, fontSize: 20),
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
