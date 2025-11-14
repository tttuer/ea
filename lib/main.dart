import 'package:flutter/material.dart';
import 'package:electronic_approval/common/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: '전자 결재',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
