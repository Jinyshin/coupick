import 'package:flutter/material.dart';

class CustomTextInputField extends StatefulWidget {
  final int? maxInputCharacters;
  final String hintString;
  final TextEditingController? controller; // Allow passing a controller

  const CustomTextInputField({
    this.maxInputCharacters,
    required this.hintString,
    this.controller, // Optional controller parameter
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
    _controller = widget.controller ?? TextEditingController(); // Use provided controller or create a new one

    _controller.addListener(() {
      setState(() {
        _currentCharacterCount = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // Only dispose if the controller is internally created
      _controller.dispose();
    }
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
            border: const UnderlineInputBorder(),
            counterText: '', // Hide the default counter text
          ),
        ),
        if (widget.maxInputCharacters != null)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '$_currentCharacterCount/${widget.maxInputCharacters}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
