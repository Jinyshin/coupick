import 'package:flutter/material.dart';
import 'package:client/services/signup_service.dart';
import 'package:client/screens/listview_vote.dart';

class UsernameCreationScreen extends StatefulWidget {
  const UsernameCreationScreen({super.key});

  @override
  _UsernameCreationScreenState createState() => _UsernameCreationScreenState();
}

class _UsernameCreationScreenState extends State<UsernameCreationScreen> {
  final TextEditingController _controller = TextEditingController();
  final SignupService _signupService = SignupService();

  Future<void> _startCoupick() async {
    if (_controller.text.isNotEmpty) {
      bool success = await _signupService.signup(_controller.text, context);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListViewVote()),
        );
      }
    } else {
      // 사용자에게 입력된 이름이 없을 때 알림
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username')),
      );
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
              onPressed: _startCoupick, // 백엔드 요청을 보내는 함수 호출
              child: const Text('Coupick 시작하기!'),
            ),
          ],
        ),
      ),
    );
  }
}
