import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_drive_file, size: 120),
                  _Title(),
                  TextField(decoration: InputDecoration(labelText: '아이디')),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: '비밀번호')),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: Text('로그인')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '로그인',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      ),
    );
  }
}
