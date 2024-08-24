import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/common/const/app_colors.dart';

class ProductInfoSection extends StatefulWidget {
  final String content;
  final String thumbnail;
  final String price;
  final String coupangUrl;

  const ProductInfoSection({
    super.key,
    required this.content,
    required this.thumbnail,
    required this.price,
    required this.coupangUrl,
  });

  @override
  _ProductInfoSectionState createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.content,
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
                  child: Image.network(
                    widget.thumbnail,
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
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₩ ${widget.price}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final url = Uri.parse(widget.coupangUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
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
      ],
    );
  }
}
