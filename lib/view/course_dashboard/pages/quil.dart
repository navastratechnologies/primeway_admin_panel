import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:quill_html_editor/quill_html_editor.dart';

import '../../helpers/app_constants.dart';

// ignore: camel_case_types
class quilscreen extends StatefulWidget {
  final String docId;
  const quilscreen({
    super.key,
    required this.docId,
  });

  @override
  State<quilscreen> createState() => _quilscreenState();
}

// ignore: camel_case_types
class _quilscreenState extends State<quilscreen> {
  final CollectionReference collaboration =
      FirebaseFirestore.instance.collection('collaboration');

  ///[controller] create a QuillEditorController to access the editor methods
  final QuillEditorController controller = QuillEditorController();
  TextEditingController deliverabletitle = TextEditingController();
  String deliveryText = '';

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
  ];

  Future uploaddeliveryFile() async {
    FirebaseFirestore.instance
        .collection('collaboration')
        .doc(widget.docId)
        .collection('deliverables')
        .add({
      'title': deliverabletitle.text,
      'data': deliveryText,
    });
  }

  @override
  void initState() {
    controller.onTextChanged((text) {
      setState(() {
        deliveryText = text;
      });
      debugPrint('listening to $text');
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: const Text(
          'Add Deliverable for Collaboration',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          MaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            elevation: 5.0,
            minWidth: 200.0,
            height: 45,
            color: purpleColor,
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: displayHeight(context),
            width: displayWidth(context) / 1.5,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: StreamBuilder(
                  stream: collaboration
                      .doc(widget.docId)
                      .collection('deliverables')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          log("lenght isfdsfsd $streamSnapshot.data!.docs.length");
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExpansionTile(
                                    title: Text(
                                      documentSnapshot['title'],
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
                                      HtmlWidget(
                                        documentSnapshot['data'],
                                        buildAsync: true,
                                        enableCaching: true,
                                      ),

                                      //
                                    ]),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(200),
            child: Center(
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                elevation: 5.0,
                minWidth: 200.0,
                height: 45,
                color: purpleColor,
                // ignore: prefer_const_constructors
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Add deliverable',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  addUnit(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  addUnit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            // vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: deliverabletitle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Deliverable Title',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                ToolBar(
                                  toolBarColor: Colors.white,
                                  padding: const EdgeInsets.all(8),
                                  iconSize: 20,
                                  activeIconColor: Colors.green,
                                  controller: controller,
                                  customButtons: [
                                    InkWell(
                                        onTap: () async {},
                                        child: const Icon(
                                          Icons.favorite,
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.add_circle,
                                        )),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.black45,
                                    child: QuillHtmlEditor(
                                      hintText: 'Hint text goes here',
                                      controller: controller,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      onTextChanged: (text) => debugPrint(
                                          'widget text change $text'),
                                      defaultFontSize: 18,
                                      defaultFontColor: Colors.black45,
                                      isEnabled: true,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5.0,
                          minWidth: 80.0,
                          height: 45,
                          color: Colors.green,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            uploaddeliveryFile();
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5.0,
                          minWidth: 80.0,
                          height: 45,
                          color: Colors.blue,
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText.toString());
  }

  /// to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);
}
