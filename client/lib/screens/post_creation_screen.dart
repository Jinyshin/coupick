import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/providers/wishlist_product_provider.dart';
import 'package:client/services/postpoll_service.dart';
import 'package:client/screens/widgets/custom_text_input_field.dart';
import 'package:client/screens/widgets/custom_elevated_button.dart';
import 'package:client/common/const/app_colors.dart';
import 'package:intl/intl.dart';


class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _contentController = TextEditingController();
  final PostPollService _postPollService = PostPollService(); // Create an instance of the service

  @override
  Widget build(BuildContext context) {
    final selectedProduct = Provider.of<ProductProvider>(context).selectedProduct;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final paddedWidth = screenWidth - 32.0;
    
    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(
          
        ),
        body: const Center(
          child: Text('No product selected!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        
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
                        '￦ ${NumberFormat('#,###').format(selectedProduct.price.toInt())}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (selectedProduct.isRocketShipping)
                        const Row(
                          children: [
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
              controller: _contentController, // Added controller
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    width: paddedWidth * 0.47,
                    text: 'Cancel',
                    textColor: AppColors.darkGray,
                    backgroundColor: AppColors.faintGray,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomElevatedButton(
                    width: paddedWidth * 0.47,
                    text: 'Confirm',
                    textColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () => _postPollService.postPoll(
                      name: selectedProduct.name,
                      price: selectedProduct.price,
                      thumbnail: selectedProduct.imageUrl,
                      content: _contentController.text,
                      coupangUrl: selectedProduct.coupangUrl,
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
