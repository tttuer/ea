import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/view/custom_search_bar.dart';
import 'dart:async';
import 'package:electronic_approval/user/provider/user_search_provider.dart';

class SearchUserScreen extends ConsumerStatefulWidget {
  const SearchUserScreen({super.key});

  @override
  ConsumerState<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends ConsumerState<SearchUserScreen> {
  String _searchQuery = '';
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userSearchState = ref.watch(userSearchNotifierProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('결재자 추가'),
          ),
          SizedBox(height: 4),
          CustomSearchBar(
            hintText: '이름 검색',
            onChanged: (value) {
              _onSearchChanged(value);
            },
            onSearch: () {
              _performSearch(_searchQuery);
            },
          ),
          SizedBox(height: 8),
          if (userSearchState.value != null &&
              userSearchState.value!.isNotEmpty)
            ...userSearchState.value!.map(
              (user) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Card(
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.userId),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      _performSearch(_searchQuery);
    });
  }

  void _performSearch(String query) async {
    if (query.isEmpty) return;
    await ref.read(userSearchNotifierProvider.notifier).search(name: query);
  }
}
