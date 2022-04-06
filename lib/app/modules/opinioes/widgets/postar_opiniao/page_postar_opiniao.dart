import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class PagePostarOpiniao extends StatelessWidget {
  PagePostarOpiniao({Key? key}) : super(key: key);
  QuillController _controller_editor = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_controller_editor.document.toDelta());
                },
                child: const Icon(Icons.add),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: QuillToolbar.basic(controller: _controller_editor)),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: QuillEditor.basic(
                  controller: _controller_editor,
                  readOnly: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
