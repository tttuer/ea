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
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        Text('결재자'),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(hintText: '결재자를 입력해주세요.')),
      ],
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
