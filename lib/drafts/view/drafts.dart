import 'package:electronic_approval/common/view/custom_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/drafts_provider.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:electronic_approval/drafts/view/drafts_filter_screen.dart';

class DraftsScreen extends ConsumerStatefulWidget {
  const DraftsScreen({super.key});

  @override
  ConsumerState<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends ConsumerState<DraftsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(draftsListNotifierProvider.notifier).fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraftsFilterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final draftsState = ref.watch(draftsListNotifierProvider);
    return draftsState.when(
      loading: () => DefaultLayout(
        child: CustomScrollView(slivers: [_SkeletonLoader(itemCount: 10)]),
      ),
      data: (Pagination<Drafts> data) => DefaultLayout(
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
          onRefresh: () async {
            ref.read(draftsListNotifierProvider.notifier).getDrafts();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: CustomFilterButton(
                  onPressed: _showFilterScreen,
                  filterCount: ref
                      .read(draftsListNotifierProvider.notifier)
                      .filterCount,
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, index) {
                  return _DraftsItem(
                    title: data.items[index].title,
                    content: data.items[index].content,
                    icon: Icons.description_outlined,
                    status: data.items[index].status,
                  );
                },
                itemCount: data.items.length,
              ),
              if (data.isLoadingMore) _SkeletonLoader(itemCount: 2),
            ],
          ),
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
  final DocumentStatus status;

  const _DraftsItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.status,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              _StatusBadge(label: status.statusText, color: status.color),
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

class _SkeletonLoader extends StatelessWidget {
  final int itemCount;
  const _SkeletonLoader({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: _DraftsItem(
            icon: Icons.description_outlined,
            title: 'title',
            content: 'content',
            status: DocumentStatus.draft,
          ),
        );
      },
      itemCount: itemCount,
    );
  }
}
