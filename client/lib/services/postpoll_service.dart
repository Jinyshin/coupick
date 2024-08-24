import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/providers/shared_preference_service.dart';
import 'package:flutter/material.dart';

class PostPollService {
  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  Future<bool> postPoll({
    required String name,
    required double price,
    required String thumbnail,
    required String content,
    required String coupangUrl,
    required BuildContext context,
  }) async {
    final url = Uri.parse('http://43.203.238.127/polls'); // Replace with the actual API endpoint

    try {
      String? token = await _sharedPreferenceService.getToken();

      if (token == null) {
        _showErrorMessage(context, 'Token is not available. Please login again.');
        return false;
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'price': price,
          'content': content,
          'thumbnail': thumbnail,
          'coupangUrl': coupangUrl,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessMessage(context, 'Post created successfully!');
        return true;
      } else {
        _handleError(response, context);
        return false;
      }
    } catch (e) {
      _showErrorMessage(context, 'An unexpected error occurred. Please try again later.');
      return false;
    }
  }

  void _handleError(http.Response response, BuildContext context) {
    String message;
    if (response.statusCode == 400) {
      message = 'Invalid request. Please check your input and try again.';
    } else if (response.statusCode == 401) {
      message = 'Unauthorized request. Please try again.';
    } else if (response.statusCode == 500) {
      message = 'Server error. Please try again later.';
    } else {
      message = 'Failed to create post. Please try again later.';
    }
    _showErrorMessage(context, message);
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
