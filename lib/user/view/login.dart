import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';
import 'package:electronic_approval/common/view/custom_input_text.dart';
import 'package:electronic_approval/common/view/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/provider/user_provider.dart';
import 'package:electronic_approval/user/model/user_request.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      16 * 2),
            ),
            child: Center(
              child: SafeArea(
                top: true,
                bottom: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Title(),
                      SizedBox(height: 16),
                      CustomInputText(
                        labelText: '아이디',
                        prefixIcon: Icons.person,
                        controller: _idController,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      CustomInputText(
                        labelText: '비밀번호',
                        prefixIcon: Icons.lock,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(onPressed: _login, text: '로그인'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomButton(onPressed: () {}, text: '회원가입'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    final id = _idController.text;
    final password = _passwordController.text;
    if (id == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('아이디 비밀번호를 확인해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ref.read(userNotifierProvider.notifier).login(UserRequest(username: id, password: password));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '전자결재 로그인',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
