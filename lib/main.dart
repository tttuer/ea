import 'package:flutter/material.dart';
import 'package:electronic_approval/common/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/logger/logger_observer.dart';

void main() {
  runApp(ProviderScope(observers: [LoggerObserver()], child: _App()));
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
