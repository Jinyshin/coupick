import 'package:flutter/material.dart';
import 'package:client/services/signup_service.dart';
import 'package:client/screens/listview_vote.dart';

Future<void> saveUsername(BuildContext context, TextEditingController controller) async {
  final SignupService _signupService = SignupService();

  if (controller.text.isNotEmpty) {
    bool success = await _signupService.signup(controller.text);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListViewVote()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup failed. Please try again.')),
      );
    }
  }
}
