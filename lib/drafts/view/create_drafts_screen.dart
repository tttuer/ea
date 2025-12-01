import 'package:electronic_approval/drafts/model/approver_line.dart';
import 'package:electronic_approval/drafts/view/search_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/view/default_layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:electronic_approval/drafts/provider/create_drafts_provider.dart';
import 'package:electronic_approval/common/view/custom_button.dart';
import 'package:electronic_approval/drafts/provider/favorite_group_provider.dart';

class CreateDraftsScreen extends ConsumerStatefulWidget {
  const CreateDraftsScreen({super.key});

  @override
  ConsumerState<CreateDraftsScreen> createState() => _CreateDraftsScreenState();
}

class _CreateDraftsScreenState extends ConsumerState<CreateDraftsScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(createDraftsProvider);
    _titleController = TextEditingController(text: state.title);
    _contentController = TextEditingController(text: state.content);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [_buildStep1(), _buildStep2(), _buildStep3()],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          _stepCircle(1, _currentStep >= 0),
          _stepLine(_currentStep >= 1),
          _stepCircle(2, _currentStep >= 1),
          _stepLine(_currentStep >= 2),
          _stepCircle(3, _currentStep >= 2),
        ],
      ),
    );
  }

  Widget _stepCircle(int step, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _stepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.blue : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildStep1() {
    final state = ref.watch(createDraftsProvider);
    final notifier = ref.read(createDraftsProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('제목'),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
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
              controller: _contentController,
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
                (file) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.attach_file),
                      title: Text(_getFileName(file)),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .read(createDraftsProvider.notifier)
                              .removeFile(file);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getFileName(String? filePath) {
    if (filePath == null) return '';
    return filePath.split('/').last;
  }

  Widget _buildStep2() {
    final favoriteGroups = ref.watch(getFavoriteGroupsProvider);
    final state = ref.watch(createDraftsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('결재선 그룹'),
            SizedBox(height: 8),
            favoriteGroups.when(
              loading: () => DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: CircularProgressIndicator(),
                  ),
                ],
                onChanged: (value) {},
              ),
              error: (error, stackTrace) => Text('Error: $error'),
              data: (data) => DropdownButtonFormField(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                hint: Text('결재선 그룹을 선택해주세요.'),
                items: data
                    .map(
                      (group) => DropdownMenuItem(
                        value: group.id,
                        child: Text(group.name),
                      ),
                    )
                    .toList(),
                onChanged: (selectedId) {
                  final selectedGroup = data.firstWhere(
                    (group) => group.id == selectedId,
                  );

                  final approverLines = selectedGroup.approverIds
                      .asMap()
                      .entries
                      .map(
                        (entry) => ApproverLine(
                          approverId: '',
                          approverUserId: selectedGroup.approverIds[entry.key],
                          approverName: selectedGroup.approverNames[entry.key],
                          stepOrder: entry.key,
                          isRequired: true,
                          isParallel: false,
                        ),
                      )
                      .toList();

                  ref
                      .read(createDraftsProvider.notifier)
                      .setApproverLines(approverLines);
                },
              ),
            ),
            SizedBox(height: 24),
            Divider(thickness: 1, color: Colors.grey.shade300),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('결재선'),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _showSearchUserScreen();
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),

            if (state.approverLines != null && state.approverLines!.isNotEmpty)
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                proxyDecorator: (child, index, animation) => AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) =>
                      Material(color: Colors.transparent, child: child),
                  child: Opacity(opacity: 0.8, child: child),
                ),
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex--;
                  }
                  ref
                      .read(createDraftsProvider.notifier)
                      .redorderApprover(oldIndex, newIndex);
                },
                children: state.approverLines!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final line = entry.value;

                  return Padding(
                    key: ValueKey(line.approverUserId),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ReorderableDragStartListener(
                              index: index,
                              child: Icon(Icons.drag_indicator),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        title: Text(line.approverName),
                        subtitle: Text('${line.stepOrder + 1} 단계'),
                        trailing: IconButton(
                          onPressed: () {
                            ref
                                .read(createDraftsProvider.notifier)
                                .removeApprover(line);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void _showSearchUserScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchUserScreen(),
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        Text('확인'),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(hintText: '결재자를 입력해주세요.')),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: CustomButton(onPressed: _previousStep, child: Text('이전')),
            ),
          if (_currentStep > 0) SizedBox(width: 8),
          Expanded(
            child: CustomButton(
              onPressed: _currentStep == 2 ? _submit : _nextStep,
              child: Text(_currentStep == 2 ? '제출' : '다음'),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() async {
    final state = ref.read(createDraftsProvider);
    if (_currentStep == 0) {
      if (state.title.isEmpty || state.content.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('제목과 내용을 입력해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    setState(() {
      _currentStep++;
    });
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _submit() async {
    ref.read(createDraftsProvider.notifier).createDraft();
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      ref
          .read(createDraftsProvider.notifier)
          .setFiles(result.files.map((file) => file.path).toList());
    }
  }
}
