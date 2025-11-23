import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/view/default_layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:electronic_approval/drafts/provider/create_drafts_provider.dart';
import 'package:electronic_approval/common/view/custom_button.dart';

class CreateDraftsScreen extends ConsumerStatefulWidget {
  const CreateDraftsScreen({super.key});

  @override
  ConsumerState<CreateDraftsScreen> createState() => _CreateDraftsScreenState();
}

class _CreateDraftsScreenState extends ConsumerState<CreateDraftsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createDraftsProvider);
    final notifier = ref.read(createDraftsProvider.notifier);

    return DefaultLayout(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('제목'),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: '결재 제목을 입력해주세요.',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                notifier.setTitle(value);
              },
            ),
            SizedBox(height: 16),
            Text('내용'),
            SizedBox(height: 8),
            TextField(
              maxLines: null,
              minLines: 5,
              decoration: InputDecoration(
                hintText: '결재 내용을 입력해주세요.',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              textInputAction: TextInputAction.newline,
              onChanged: (value) {
                notifier.setContent(value);
              },
            ),
            SizedBox(height: 16),
            Text('첨부파일 (선택사항)'),
            SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _pickFiles,
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.indigoAccent),
                  Text('첨부파일 선택', style: TextStyle(color: Colors.indigoAccent)),
                ],
              ),
            ),

            if (state.files != null && state.files!.isNotEmpty)
              ...state.files!.map(
                (file) => ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text(file ?? ''),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(createDraftsProvider.notifier).removeFile(file);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),

            SizedBox(height: 16),
            CustomButton(
              onPressed: () async {
                await _checkCreateDraft();
              },
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkCreateDraft() async {
    final state = ref.read(createDraftsProvider);
    if (state.title.isEmpty || state.content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('제목과 내용을 입력해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      ref
          .read(createDraftsProvider.notifier)
          .setFiles(result.files.map((file) => file.path).toList());
    }
  }
}
