import 'package:flutter/material.dart';

class CustomTextInputField extends StatefulWidget {
  final int? maxInputCharacters;
  final String hintString;

  const CustomTextInputField({
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
            border: const OutlineInputBorder(),
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
