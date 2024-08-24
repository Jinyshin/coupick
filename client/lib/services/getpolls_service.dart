import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/providers/shared_preference_service.dart';
import 'package:client/models/polls.dart';

class GetPollsService {
  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  Future<List<Poll>> getPolls() async {
    final url = Uri.parse('http://43.203.238.127/polls'); // 실제 API 엔드포인트로 대체

    // SharedPreferences에서 저장된 accessToken 가져오기
    String? token = await _sharedPreferenceService.getToken();

    if (token == null) {
      throw Exception('Token is not available. Please login again.');
    }

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);

        // data 타입 및 구조 확인
        print('Decoded JSON: $data');

        if (data is List) {
          // 각 poll 항목의 타입과 내용을 확인
          data.forEach((poll) {
            print('Poll item: $poll, Type: ${poll.runtimeType}');
          });

          final polls = data.map((poll) => Poll.fromJson(poll)).toList();
          return polls;
        } else if (data is Map && data['polls'] is List) {
          final pollsList = data['polls'] as List;

          // 각 poll 항목의 타입과 내용을 확인
          pollsList.forEach((poll) {
            print('Poll item: $poll, Type: ${poll.runtimeType}');
          });

          final polls = pollsList.map((poll) => Poll.fromJson(poll)).toList();
          return polls;
        } else {
          throw Exception('Unexpected JSON structure: $data');
        }
      } catch (e) {
        // JSON 파싱 중 발생한 오류 로그 출력
        print('Error parsing JSON: $e');
        throw Exception('Failed to parse polls data.');
      }
    } else {
      throw Exception('Failed to load polls. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }
}