import 'package:flutter/material.dart';
import 'package:client/providers/shared_preference_service.dart';
import 'package:client/screens/signup.dart';

Future<void> logout(BuildContext context) async {
  final SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  // SharedPreferences에서 토큰과 유저 이름 삭제
  await sharedPreferenceService.removeToken();
  await sharedPreferenceService.removeUsername();

  // 로그아웃 후 사용자 이름 생성 페이지로 이동
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const UsernameCreationScreen()),
        (Route<dynamic> route) => false,
  );
}
