import 'package:client/common/const/app_colors.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: _ProductInfoSection(),
            ),
            Expanded(
              flex: 2,
              child: _ReactionSection(),
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
      children: [
        Expanded(
          flex: 4,
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
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 'more info' 버튼이 눌렸을 때의 동작 추가
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGray,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      ),
                      child: const Row(
                        children: [
                          Text('more info'),
                          SizedBox(width: 4.0),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
        const Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₩ 18,000',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'What do you think of this ROKA T-shirt? I want to be a cool girl',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 8),
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
                    padding: const EdgeInsets.all(16.0),
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
                          title: Text('User $index'),
                          subtitle: Text('This is the reaction of user $index'),
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
                        color: Colors.yellow, size: 48),
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
                        color: Colors.yellow, size: 48),
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
