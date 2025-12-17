import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/provider/user_search_provider.dart';
import 'package:electronic_approval/user/model/user_response.dart';
import 'package:electronic_approval/common/view/custom_autocomplete_search.dart';
import 'package:electronic_approval/common/view/custom_button.dart';
import 'package:electronic_approval/drafts/provider/create_drafts_provider.dart';
import 'package:electronic_approval/drafts/model/approver_line.dart';

class SearchUserScreen extends ConsumerStatefulWidget {
  const SearchUserScreen({super.key});

  @override
  ConsumerState<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends ConsumerState<SearchUserScreen> {
  List<UserResponse> _selectedUsers = [];
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomAutocompleteSearch<UserResponse>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                return await ref
                    .read(userSearchNotifierProvider.notifier)
                    .search(name: textEditingValue.text);
              },
              displayStringForOption: (UserResponse user) => user.name,
              onSelected: (UserResponse user) {
                if (!_selectedUsers.any(
                  (element) => element.userId == user.userId,
                )) {
                  setState(() {
                    _selectedUsers.add(user);
                  });
                }
              },
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedUsers.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: ListTile(
                    title: Text(_selectedUsers[index].name),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedUsers.removeWhere(
                            (element) =>
                                element.userId == _selectedUsers[index].userId,
                          );
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('취소'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        final currentApprovers =
                            ref.read(createDraftsProvider).approverLines ?? [];
                        final newApprovers = _selectedUsers
                            .map(
                              (user) => ApproverLine(
                                approverId: '',
                                approverUserId: user.userId,
                                approverName: user.name,
                                stepOrder: currentApprovers.length + 1,
                                isRequired: true,
                                isParallel: false,
                              ),
                            )
                            .toList();

                        ref
                            .read(createDraftsProvider.notifier)
                            .addApprovers(newApprovers);
                        Navigator.pop(context);
                      },
                      child: Text('확인'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
