import 'package:client/common/const/app_colors.dart';
import 'package:client/models/polls.dart';
import 'package:client/screens/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PollDetailCard extends StatefulWidget {
  final Poll poll;

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
                      itemCount: widget.poll.comments.length,
                      itemBuilder: (context, index) {
                        final comment = widget.poll.comments[index];
                        return ListTile(
                          leading: Icon(
                            comment.isLiked ? Icons.thumb_up : Icons.thumb_down,
                            color: comment.isLiked
                                ? AppColors.lightblueLogoColor
                                : AppColors.yellowLogoColor,
                          ),
                          title: Text('${comment.name}: ${comment.content}'),
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
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.poll.content,
                    style: const TextStyle(
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
                          // child: Image.asset(
                          //   'assets/images/roka.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.network(
                            widget.poll.thumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              );
                            },
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
                    Text(
                      '₩ ${widget.poll.price.toInt()}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final url = Uri.parse(widget.poll.coupangUrl);
                        print('Attempting to launch $url');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                          print('Launch successful');
                        } else {
                          print('Could not launch $url');
                          throw 'Could not launch $url';
                        }
                      },
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
              ProgressBar(
                likes: widget.poll.likes,
                dislikes: widget.poll.dislikes,
              ),
              const SizedBox(height: 12),
              widget.poll.comments.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _showReactions(context),
                          child: const Text(
                            'Show all reactions',
                            style: TextStyle(
                                color: AppColors.middleGray, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              widget.poll.comments[0].isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_down,
                              color: widget.poll.comments[0].isLiked
                                  ? AppColors.lightblueLogoColor
                                  : AppColors.yellowLogoColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.poll.comments[0].content,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(), // comments가 비어있을 때 빈 Container로 대체
            ],
          ),
        ));
  }
}
