import 'package:client/common/const/app_colors.dart';
import 'package:client/models/temp_poll_detail_model.dart';
import 'package:client/screens/widgets/progressbar.dart';
import 'package:flutter/material.dart';

class PollDetailCard extends StatefulWidget {
  final PollDetailModel poll;

  const PollDetailCard(
    this.poll, {
    super.key,
  });

  @override
  State<PollDetailCard> createState() => _PollDetailCardState();
}

class _PollDetailCardState extends State<PollDetailCard> {
  bool isFavorite = false;

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
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
                                  const SnackBar(
                                      content: Text('Added to wishlist.')),
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
                      '₩ 18,000',
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
            ],
          ),
        ));
  }
}
