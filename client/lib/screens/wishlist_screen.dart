import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../providers/wishlist_product_provider.dart';
import 'post_creation_screen.dart';
import 'package:intl/intl.dart';
import '../models/wishlist_product.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late InAppWebViewController webViewController;
  final TextEditingController _urlController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic>? productDetails;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog(context, productProvider);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: productProvider.wishlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns per row
            childAspectRatio: 0.6, // Adjusted aspect ratio
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
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxWidth;
                        return Stack(
                          children: [
                            Container(
                              width: width,
                              height: width,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: product.imageUrl.isEmpty
                                    ? Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.grey[600],
                                        ),
                                      )
                                    : Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                              ),
                            ),
                            if (product.isRocketShipping)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.rocket_launch,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '로켓배송',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const Positioned(
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
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '￦ ${NumberFormat('#,###').format(product.price.toInt())}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
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

  void _showAddItemDialog(BuildContext context, ProductProvider productProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> _fetchProductInfo() async {
              setState(() {
                isLoading = true;
              });
              try {
                if (_urlController.text.isEmpty || !Uri.tryParse(_urlController.text)!.isAbsolute) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid URL'),
                    ),
                  );
                  return;
                }

                // Load the URL in WebView
                await webViewController.loadUrl(
                  urlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(_urlController.text)),
                  ),
                );

                // Introduce a slight delay to ensure the page has fully rendered
                await Future.delayed(const Duration(seconds: 2));

                // Wait for the page to fully load and perform scraping
                String? title = await webViewController.evaluateJavascript(
                  source: "document.querySelector('.prod-buy-header__title')?.innerText;",
                );
                print('Title: $title');

                String? price = await webViewController.evaluateJavascript(
                  source: "document.querySelector('.total-price')?.innerText;",
                );
                print('Price: $price');

                String? imageUrl = await webViewController.evaluateJavascript(
                  source: """
                  (() => {
                    const zoomWindow = document.querySelector('.zoomWindow');
                    if (zoomWindow && zoomWindow.style.backgroundImage) {
                      return zoomWindow.style.backgroundImage.slice(5, -2).replace('&quot;', '');
                    }
                    return null;
                  })();
                  """,
                );

                // If the first attempt to get imageUrl fails, try another method
                if (imageUrl == null || imageUrl.isEmpty) {
                  imageUrl = await webViewController.evaluateJavascript(
                    source: "document.querySelector('.prod-image__detail img')?.getAttribute('src');",
                  );
                }

                print('Image URL: $imageUrl');

                bool isRocketShipping = await webViewController.evaluateJavascript(
                  source: "document.querySelector('.td-delivery-badge') != null;",
                ) as bool;
                print('Is Rocket Shipping: $isRocketShipping');

                productDetails = {
                  'name': title ?? 'Unknown',
                  'price': double.tryParse(price?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ?? 0.0,
                  'imageUrl': imageUrl ?? '',
                  'isRocketShipping': isRocketShipping,
                };

                setState(() {
                  isLoading = false;
                });
              } catch (e) {
                print('Error fetching product info: $e');
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to retrieve product information'),
                  ),
                );
              }
            }

            return AlertDialog(
              title: const Text('Add New Item'),
              content: Container(
                width: double.maxFinite,
                height: 400,  // Adjust the height as needed
                child: Column(
                  children: [
                    Expanded(
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(
                          url: WebUri.uri(Uri.parse('https://www.example.com')), // Default URL or a valid fallback
                        ),
                        initialSettings: InAppWebViewSettings(
                          userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
                        ),
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                          print("WebView created, controller initialized.");
                        },
                        shouldOverrideUrlLoading: (controller, navigationAction) async {
                          var uri = navigationAction.request.url!;

                          if (uri.scheme == "coupang") {
                            print("Custom scheme detected: ${uri.scheme}, URL: $uri");
                            return NavigationActionPolicy.CANCEL;
                          }

                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          print("Page loaded: $url");
                        },
                      ),
                    ),
                    TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Coupang URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                if (productDetails != null)
                  TextButton(
                    onPressed: () {
                      if (productDetails != null) {
                        productProvider.addProduct(Product(
                          name: productDetails!['name'] ?? 'Unknown',
                          price: productDetails!['price'] ?? 0.0,
                          imageUrl: productDetails!['imageUrl'] ?? '',
                          coupangUrl: _urlController.text,
                          isRocketShipping: productDetails!['isRocketShipping'] ?? false,
                        ));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to wishlist'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add to Wishlist'),
                  ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          print("Confirming URL: ${_urlController.text}");
                          await _fetchProductInfo();
                        },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
