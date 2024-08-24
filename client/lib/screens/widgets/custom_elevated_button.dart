import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.width,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
