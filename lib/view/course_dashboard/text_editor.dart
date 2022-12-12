import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditerPage extends StatefulWidget {
  const TextEditerPage({super.key});

  @override
  State<TextEditerPage> createState() => _TextEditerPageState();
}

QuillController quillController = QuillController.basic();

class _TextEditerPageState extends State<TextEditerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 700,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            children: [
              QuillToolbar.basic(
                controller: quillController,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: QuillEditor.basic(
                    controller: quillController,
                    readOnly: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
