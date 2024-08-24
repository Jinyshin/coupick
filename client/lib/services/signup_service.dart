import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/providers/shared_preference_service.dart';

class SignupService {
  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  Future<bool> signup(String username) async {
    final url = Uri.parse('https://your-backend-api.com/signup'); // 실제 API 엔드포인트로 대체

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // 토큰 및 유저 이름을 SharedPreferences에 저장
      await _sharedPreferenceService.saveToken(token);
      await _sharedPreferenceService.saveUsername(username);

      return true; // 성공적으로 토큰을 받아 저장한 경우
    } else {
      // 요청 실패 시 처리
      return false;
    }
  }
}
