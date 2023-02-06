import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class MyApp extends StatelessWidget {
  final QuillEditorController _controller = QuillEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quill HTML Editor'),
      ),
      body: Container(
        height: 500,
        child: QuillHtmlEditor(
          height: 50,
          controller: _controller,
        ),
      ),
    );
  }
}
