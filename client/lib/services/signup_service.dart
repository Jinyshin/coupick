import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/providers/shared_preference_service.dart';
import 'package:flutter/material.dart';

class SignupService {
  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  Future<bool> signup(String username, BuildContext context) async {
    final url = Uri.parse('http://43.203.238.127/users'); // 실제 API 엔드포인트로 대체

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': username}), // "username" 대신 "name"으로 변경
      );

      if (response.statusCode == 200 || response.statusCode == 201) { // 200과 201 모두 성공 처리
        final data = jsonDecode(response.body);
        final accessToken = data['accessToken']; // "token" 대신 "accessToken" 사용

        // 토큰 및 유저 이름을 SharedPreferences에 저장
        await _sharedPreferenceService.saveToken(accessToken);
        await _sharedPreferenceService.saveUsername(username);

        // 성공시에도 로그에 출력
        String? savedUsername = await _sharedPreferenceService.getUsername();
        String? savedToken = await _sharedPreferenceService.getToken();

        print('Saved Username: $savedUsername');
        print('Saved Access Token: $savedToken');
        
        return true; // 성공적으로 토큰을 받아 저장한 경우
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
      message = 'Failed to sign up. Please try again later.';
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
}
