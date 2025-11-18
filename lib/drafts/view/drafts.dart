import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';

class DraftsScreen extends StatelessWidget {
  const DraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (context, index) {
              return _DraftsItem(
                title: 'Drafts',
                content: 'Drafts',
                icon: Icons.description_outlined,
              );
            },
            itemCount: 15,
          ),
        ],
      ),
    );
  }
}

class _DraftsItem extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _DraftsItem({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon),
                    ),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              _StatusBadge(label: '결재대기', color: Colors.yellow),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade300, height: 1, thickness: 1),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(fontSize: 13)),
    );
  }
}
