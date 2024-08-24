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
        title: const Text('Select your coupick item:'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.zero, // Remove any padding from GridView
        itemCount: productProvider.wishlist.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Three columns per row
          childAspectRatio: 0.5, // Adjust the aspect ratio to increase height
          crossAxisSpacing: 0, // No spacing between columns
          mainAxisSpacing: 0, // No spacing between rows
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
            child: Container(
              color: Colors.white, // Use a plain Container with no elevation or radius
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Padding inside the Container for content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, // Align all content to the top
                  children: [
                    Container(
                      width: double.infinity, // Ensure the image container stretches across the width
                      height: 100, // Set a fixed height to make the container square
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Background color for the image placeholder
                      ),
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
                    const SizedBox(height: 8), // Small gap between image and text
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2, // Restrict title to at most 2 lines
                      overflow: TextOverflow.ellipsis, // Ellipsize overflowing text
                    ),
                    const SizedBox(height: 4), // Reduced gap between name and price
                    Text(
                      product.price,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.isRocketShipping)
                      Padding(
                        padding: const EdgeInsets.only(top: 4), // Minimal padding above the shipping label
                        child: Row(
                          children: const [
                            Icon(Icons.rocket_launch, size: 16, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              '로켓배송',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12, // Adjusted font size for shipping label
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
