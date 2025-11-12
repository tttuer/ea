import 'package:electronic_approval/user/view/login.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => LoginPage())],
);
