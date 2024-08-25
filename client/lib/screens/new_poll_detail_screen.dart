import 'package:client/models/temp_poll_detail_model.dart';
import 'package:client/screens/like_reaction_screen.dart';
import 'package:client/screens/widgets/poll_detail_card.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/dislike_reaction_screen.dart'; // DisLikeReactionScreen import

class Example extends StatefulWidget {
  const Example({
    super.key,
  });

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();
  final cards = polls.map(PollDetailCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    cards[index],
                isLoop: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'thumb_down', // 고유한 heroTag 지정
                    onPressed: () async {
                      // DisLikeReactionScreen으로 이동하고 결과를 기다림
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          // TODO: handle pollId
                          builder: (context) => const DisLikeReactionScreen(
                            pollId: '',
                          ),
                        ),
                      );

                      // DisLikeReactionScreen에서 돌아오면 카드 스와이프
                      if (result == true) {
                        controller.swipe(CardSwiperDirection.left);
                      }
                    },
                    child: const Icon(Icons.thumb_down),
                  ),
                  FloatingActionButton(
                    heroTag: 'arrow_up',
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    heroTag: 'thumb_up',
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        // TODO: handle pollId
                        MaterialPageRoute(
                          builder: (context) =>
                              const LikeReactionScreen(pollId: ''),
                        ),
                      );

                      if (result == true) {
                        controller.swipe(CardSwiperDirection.right);
                      }
                    },
                    child: const Icon(Icons.thumb_up),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }
}
