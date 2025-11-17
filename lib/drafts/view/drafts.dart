import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';

class DraftsScreen extends StatelessWidget {
  const DraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: Column(
      children: [
        Text('Drafts'),
      ],
    ));
  }
}