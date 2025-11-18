import 'package:electronic_approval/user/view/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:electronic_approval/drafts/view/drafts.dart';
import 'package:electronic_approval/common/view/default_layout.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    ShellRoute(
      builder: (context, state, child) {
        final routeName = state.topRoute?.name;

        final titles = {'drafts': '기안함'};

        return DefaultLayout(
          appBar: AppBar(
            title: Text(titles[routeName] ?? '전자결재'),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Container(color: Colors.grey.shade300, height: 1),
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.account_circle_outlined), iconSize: 30,)],
          ),
          drawer: const _Drawer(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/drafts',
          name: 'drafts',
          builder: (context, state) => DraftsScreen(),
        ),
      ],
    ),
  ],
);

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Text(
                '전자 결재',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.description_outlined),
                SizedBox(width: 8),
                Text(
                  '기안함',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            onTap: () {
              context.goNamed('drafts');
            },
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.hourglass_top_outlined),
                SizedBox(width: 8),
                Text('결재대기'),
              ],
            ),
            onTap: () {
              context.goNamed('drafts');
            },
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.check_circle_outline_outlined),
                SizedBox(width: 8),
                Text('결재함'),
              ],
            ),
            onTap: () {
              context.goNamed('drafts');
            },
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.people_alt_outlined),
                SizedBox(width: 8),
                Text('결재선 그룹'),
              ],
            ),
            onTap: () {
              context.goNamed('drafts');
            },
          ),
        ],
      ),
    );
  }
}
