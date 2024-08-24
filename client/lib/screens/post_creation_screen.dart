import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_product_provider.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedProduct = Provider.of<ProductProvider>(context).selectedProduct;

    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Write your coupick post:'),
        ),
        body: const Center(
          child: Text('No product selected!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Write your coupick post:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (selectedProduct.imageUrl.isEmpty)
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 60, // Increased size for the placeholder icon
                      color: Colors.grey,
                    ),
                  )
                else
                  Image.network(
                    selectedProduct.imageUrl,
                    width: 120, // Increased width for larger image display
                    height: 120, // Increased height for larger image display
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 16), // Increased spacing between image and text
                Expanded( // To ensure the text does not overflow the screen width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedProduct.name,
                        style: const TextStyle(
                          fontSize: 18, // Increased font size for the product name
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5), // Small space between name and price
                      Text(
                        selectedProduct.price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22, // Increased font size for the price
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5), // Small space between price and shipping
                      if (selectedProduct.isRocketShipping)
                        Row(
                          children: const [
                            Icon(Icons.rocket_launch, size: 20, color: Colors.blue), // Same rocket icon
                            SizedBox(width: 4),
                            Text(
                              '로켓배송',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16, // Increased font size for the shipping text
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Increased space before the text fields
            const TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 18), // Increased font size for the label
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
