import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/drafts_provider.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';

class DraftsScreen extends ConsumerStatefulWidget {
  const DraftsScreen({super.key});

  @override
  ConsumerState<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends ConsumerState<DraftsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(draftsListNotifierProvider.notifier).getDrafts();
  }

  @override
  Widget build(BuildContext context) {
    final draftsState = ref.watch(draftsListNotifierProvider);
    return draftsState.when(
      loading: () => DefaultLayout(child: CircularProgressIndicator()),
      data: (Pagination<Drafts> data) => DefaultLayout(
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
              itemCount: data.items.length,
            ),
          ],
        ),
      ),
      error: (error, stackTrace) =>
          DefaultLayout(child: Text(error.toString())),
    );
  }
}

class _DraftsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _DraftsItem({
    required this.icon,
    required this.title,
    required this.content,
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
