import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/providers/shared_preference_service.dart';

class LikeService {
  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  Future<bool> submitLike(String pollId, bool like, {String? comment}) async {
    final token = await _sharedPreferenceService.getToken();

    if (token == null) {
      throw Exception('Token is not available. Please log in again.');
    }

    final url = Uri.parse('http://43.203.238.127/polls/$pollId/likes');

    // 보낼 데이터를 디버깅 로그로 출력
    // Body 데이터 생성
    final body = jsonEncode({
      'like': like,
      'comment': comment,
    });

    // Body 데이터 로그 출력
    print('Sending POST request to $url with body: $body');


    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'like': like,
        'comment': comment,
      }),
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      print('POST successful: ${response.body}');
      return true;
    } else {
      throw Exception('Failed to submit reaction: ${response.body}');
    }
  }
}
