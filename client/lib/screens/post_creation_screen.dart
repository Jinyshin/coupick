import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_product_provider.dart';

// Assuming you have already defined CustomTextInputField widget earlier
class CustomTextInputField extends StatefulWidget {
  final int? maxInputCharacters;
  final String hintString;

  CustomTextInputField({
    this.maxInputCharacters,
    required this.hintString,
  });

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late TextEditingController _controller;
  int _currentCharacterCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _currentCharacterCount = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          maxLength: widget.maxInputCharacters,
          decoration: InputDecoration(
            hintText: widget.hintString,
            border: OutlineInputBorder(),
            counterText: '', // Hide the default counter text
          ),
        ),
        if (widget.maxInputCharacters != null)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '${_currentCharacterCount}/${widget.maxInputCharacters}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}

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
                      size: 60,
                      color: Colors.grey,
                    ),
                  )
                else
                  Image.network(
                    selectedProduct.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedProduct.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        selectedProduct.price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (selectedProduct.isRocketShipping)
                        Row(
                          children: const [
                            Icon(Icons.rocket_launch, size: 20, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              '로켓배송',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomTextInputField(
              maxInputCharacters: 30,
              hintString: 'Tell us about this item :)',
            ),
          ],
        ),
      ),
    );
  }
}
