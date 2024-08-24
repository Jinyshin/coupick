import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameCreationScreen extends StatefulWidget {
  const UsernameCreationScreen({super.key});

  @override
  _UsernameCreationScreenState createState() => _UsernameCreationScreenState();
}

class _UsernameCreationScreenState extends State<UsernameCreationScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveUsername() async {
    if (_controller.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _controller.text);
      await prefs.setString('token', 'your_generated_token'); // 토큰 저장
      Navigator.pushReplacementNamed(context, '/vote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Username')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100, // 로고 이미지의 높이 조정
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your username'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUsername,
              child: const Text('Coupick 시작하기!'),
            ),
          ],
        ),
      ),
    );
  }
}
