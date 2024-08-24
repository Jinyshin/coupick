// screens/wishlist_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_product_provider.dart';
import 'post_creation_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left), // Left chevron button
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: null, // Removed the header text
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding around the entire GridView
        child: GridView.builder(
          itemCount: productProvider.wishlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns per row
            childAspectRatio: 0.65, // Adjusted aspect ratio
            crossAxisSpacing: 8, // Spacing between columns
            mainAxisSpacing: 8, // Spacing between rows
          ),
          itemBuilder: (context, index) {
            final product = productProvider.wishlist[index];
            return GestureDetector(
              onTap: () {
                productProvider.selectProduct(product);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostCreationScreen(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                ),
                elevation: 0, // Removed shadow by setting elevation to 0
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxWidth;
                        return Stack(
                          children: [
                            Container(
                              width: width, // Set width to max width available
                              height: width, // Set height equal to width to make it square
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ), // Rounded corners only at the top
                                child: product.imageUrl.isEmpty
                                    ? Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.grey[600],
                                        ), // Show placeholder icon when imageUrl is empty
                                      )
                                    : Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ), // Show image when imageUrl is not empty
                              ),
                            ),
                            if (product.isRocketShipping)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.rocket_launch, // Rocket icon
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '로켓배송',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14, // Increased font size for "로켓배송"
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 8), // Small gap between image and text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16, // Increased font size for title
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2, // Restrict title to at most 2 lines
                        overflow: TextOverflow.ellipsis, // Ellipsize overflowing text
                      ),
                    ),
                    const SizedBox(height: 4), // Reduced gap between name and price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20, // Increased font size for price
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
