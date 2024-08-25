// widgets/add_post.dart
import 'package:flutter/material.dart';
import '../wishlist_screen.dart';
import '../../common/const/app_colors.dart';

class AddPostButton extends StatefulWidget {
  final ScrollController scrollController;

  const AddPostButton({super.key, required this.scrollController});

  @override
  _AddPostButtonState createState() => _AddPostButtonState();
}

class _AddPostButtonState extends State<AddPostButton> {
  bool isAtTop = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController.offset > 0 && isAtTop) {
      setState(() {
        isAtTop = false;
      });
    } else if (widget.scrollController.offset <= 0 && !isAtTop) {
      setState(() {
        isAtTop = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: isAtTop ? 100 : 64, // Width expands to 100 when at the top, and to 64 when collapsed
      height: isAtTop ? 48 : 64, // Height remains 56 when at the top, and increases to 64 when collapsed
      decoration: BoxDecoration(
        color: AppColors.primaryColor, // Use AppColor's primary color
        borderRadius: BorderRadius.circular(isAtTop ? 32 : 32), // More rounded when collapsed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Slightly darker shadow
            blurRadius: 12, // More blur for a softer shadow
            offset: const Offset(4, 4), // Shadow towards the bottom-right
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to WishlistScreen when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishlistScreen(),
            ),
          );
        },
        child: Center( // Ensure the button content is centered
          child: Row(
            mainAxisSize: MainAxisSize.min, // Ensures Row takes minimal space needed
            mainAxisAlignment: MainAxisAlignment.center, // Center align horizontally within the Row
            crossAxisAlignment: CrossAxisAlignment.center, // Center align vertically within the Row
            children: [
              Icon(
                Icons.add,
                size: isAtTop ? 24 : 32, // Larger icon size when collapsed
                color: Colors.white,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: child,
                  );
                },
                child: isAtTop
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Align( // Ensures the text is centered vertically
                          alignment: Alignment.center,
                          child: Text(
                            '글쓰기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        key: ValueKey('글쓰기'), // Unique key for AnimatedSwitcher
                      )
                    : const SizedBox.shrink(), // Empty widget when not at the top
              ),
            ],
          ),
        ),
      ),
    );
  }
}
