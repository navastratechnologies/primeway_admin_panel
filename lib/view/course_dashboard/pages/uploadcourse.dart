// ignore_for_file: invalid_return_type_for_catch_error, unused_field

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/showPdf_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/text_editor.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart'
    as imagesource;

class UploadCoursesScreen extends StatefulWidget {
  final String courseId;
  const UploadCoursesScreen({super.key, required this.courseId});

  @override
  State<UploadCoursesScreen> createState() => _UploadCoursesScreenState();
}

class _UploadCoursesScreenState extends State<UploadCoursesScreen> {
  TextEditingController chapterTitleController = TextEditingController();
  TextEditingController chapterDescriptionController = TextEditingController();

  TextEditingController lessonNameController = TextEditingController();
  TextEditingController lessoneDescriptionController = TextEditingController();
  TextEditingController waterMarkPositionController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  bool showWarning = false;

  String videoUrl =
      '<iframe width="10" height="10" src="" title="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';

  String draft = 'Draft';
  String type = 'Audio Book';
  var items = [
    "Audio Book",
    "Document",
    "Video",
  ];

  String chapters = '';
  String chapterCounts = '';

  final CollectionReference course =
      FirebaseFirestore.instance.collection('courses');

  Future getCourseChaptersData() async {
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .get()
        .then((value) {
      setState(() {
        chapters = value.get('chapters');
      });
    });
    log('chapter count is $chapters');
  }

  Future createChapter() async {
    course
        .doc(widget.courseId)
        .collection('chapters')
        .doc(chapterTitleController.text)
        .set({
      'title': chapterTitleController.text,
      'description': chapterDescriptionController.text,
      'publish_unit': draft,
      'video_count': '',
    });
    course.doc(widget.courseId).update({
      'chapters': "${int.parse(chapters) + 1}",
    });
  }

  File? pickedFile;
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  Uint8List webAudio = Uint8List(8);
  Uint8List webVideo = Uint8List(8);
  Uint8List webDoc = Uint8List(8);

  Future<void> pickImage() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image =
          await picker.pickImage(source: imagesource.ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          pickedFile = selected;
        });
      } else {
        log('no image has been selected');
      }
    } else if (kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image =
          await picker.pickImage(source: imagesource.ImageSource.gallery);
      if (image != null) {
        var selectedByte = await image.readAsBytes();
        setState(() {
          webImage = selectedByte;
          pickedFile = File('a');
        });
      } else {
        log('no image has been selected');
      }
    } else {
      log('something went wrong');
    }
  }

  File? pickDocFileType, pickVideoFileType, pickAudioFileType;
  String? fileurl, fileType;
  String filename = '';

  pickAnyFileFunction(FileType type) async {
    if (type == FileType.custom) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result == null) return;

      var selectedByte = result.files.first;
      log('file byte is ${selectedByte.name}');
      setState(() {
        webDoc = selectedByte.bytes!;
        filename = selectedByte.name;
        fileType = "Document";
        pickDocFileType = File('a');
      });
    } else if (type == FileType.video) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
      );
      if (result == null) return;

      var selectedByte = result.files.first;
      log('file byte is ${selectedByte.name}');
      setState(() {
        webVideo = selectedByte.bytes!;
        filename = selectedByte.name;
        fileType = "Video";
        pickVideoFileType = File('a');
      });
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
      );
      if (result == null) return;

      var selectedByte = result.files.first;
      log('file byte is ${selectedByte.name}');
      setState(() {
        webAudio = selectedByte.bytes!;
        filename = selectedByte.name;
        fileType = "Audio Book";
        pickAudioFileType = File('a');
      });
    }
  }

  Future uploadAnyFileFunction(FileType type, id) async {
    if (type == FileType.custom) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('course_videos/${DateTime.now()}.pdf');
      UploadTask uploadTask = ref.putData(
        webDoc,
        SettableMetadata(contentType: 'application/pdf'),
      );
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
        () {
          for (var i = 0; i < 4; i++) {
            Navigator.pop(context);
          }
        },
      ).catchError(
        (error) => log('something went wrong'),
      );
      String url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        fileurl = url;
      });
    } else if (type == FileType.video) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('course_videos/${DateTime.now()}.mp4');
      UploadTask uploadTask = ref.putData(
        webVideo,
        SettableMetadata(contentType: 'video/mp4'),
      );
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
        () {
          for (var i = 0; i < 4; i++) {
            Navigator.pop(context);
          }
        },
      ).catchError(
        (error) => log('something went wrong'),
      );
      String url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        fileurl = url;
      });
    } else {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('course_videos/${DateTime.now()}.mp3');
      UploadTask uploadTask = ref.putData(
        webAudio,
        SettableMetadata(contentType: 'audio/mpeg'),
      );
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
        () {
          for (var i = 0; i < 4; i++) {
            Navigator.pop(context);
          }
        },
      ).catchError(
        (error) => log('something went wrong'),
      );
      String url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        fileurl = url;
      });
    }
    FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .collection('chapters')
        .doc(id)
        .collection('videos')
        .add(
      {
        "title": lessonNameController.text,
        "duration": durationController.text,
        "description": lessoneDescriptionController.text,
        "water_position": waterMarkPositionController.text,
        "url": fileurl,
        "type": fileType,
      },
    );
  }

  @override
  void initState() {
    getCourseChaptersData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: const Text(
          'Chapters',
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
              'Add New Chapter',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              addUnit(context);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: course.doc(widget.courseId).collection('chapters').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: displayHeight(context),
                width: displayWidth(context),
                child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(documentSnapshot.id),
                            textColor: Colors.blue,
                            trailing: IconButton(
                              onPressed: () {
                                try {
                                  var id = documentSnapshot.id;
                                  getCourseChaptersData();
                                  addlesson(context, id);
                                  log('This is document id : $id');
                                } catch (e) {
                                  log('Error is : $e');
                                }
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            children: [
                              StreamBuilder(
                                stream: course
                                    .doc(widget.courseId)
                                    .collection('chapters')
                                    .doc(documentSnapshot.id)
                                    .collection('videos')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot>
                                        streamSnapshot) {
                                  if (streamSnapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          streamSnapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final DocumentSnapshot
                                            documentSnapshotVideo =
                                            streamSnapshot.data!.docs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            width: displayWidth(context),
                                            height:
                                                documentSnapshotVideo['type'] ==
                                                        "Video"
                                                    ? 200
                                                    : documentSnapshotVideo[
                                                                'type'] ==
                                                            "Document"
                                                        ? 40
                                                        : 120,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 30.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          documentSnapshotVideo[
                                                                      'type'] ==
                                                                  "Video"
                                                              ? Icons
                                                                  .movie_rounded
                                                              : documentSnapshotVideo[
                                                                          'type'] ==
                                                                      "Audio Book"
                                                                  ? Icons
                                                                      .audio_file_rounded
                                                                  : Icons
                                                                      .description_rounded,
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                        ),
                                                        Text(
                                                          documentSnapshotVideo[
                                                              'title'],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 100),
                                                SizedBox(
                                                  width:
                                                      displayWidth(context) / 3,
                                                  height: documentSnapshotVideo[
                                                              'type'] ==
                                                          "Video"
                                                      ? 200
                                                      : documentSnapshotVideo[
                                                                  'type'] ==
                                                              "Document"
                                                          ? 40
                                                          : 120,
                                                  child: documentSnapshotVideo[
                                                              'type'] ==
                                                          "Document"
                                                      ? MaterialButton(
                                                          color:
                                                              greenShadeColor,
                                                          onPressed: () =>
                                                              Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewPdfScreen(
                                                                pdfString:
                                                                    '<iframe src="${documentSnapshotVideo['url']}" title="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              'View Document'),
                                                        )
                                                      : HtmlWidget(
                                                          """<iframe src="${documentSnapshotVideo['url']}" title="" frameborder="0" allow="accelerometer; autoplay="false"; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen allow></iframe>""",
                                                          buildAsync: true,
                                                          enableCaching: true,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  addlesson(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                height: 200,
                width: 300,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.plus_one,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      //width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: AlertDialog(
                                        title: Container(
                                          //width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 30),
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: greenShadeColor,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'Lesson Type',
                                                style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: DropdownButtonFormField(
                                                  decoration:
                                                      const InputDecoration(),
                                                  value: type,
                                                  items:
                                                      items.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      type = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50),
                                                child: Row(
                                                  children: [
                                                    MaterialButton(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(0.0),
                                                        ),
                                                      ),
                                                      elevation: 5.0,
                                                      minWidth: 100.0,
                                                      height: 45,
                                                      color: greenShadeColor,
                                                      child: const Text(
                                                        'Create Lesson',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        try {
                                                          uploadlesson(
                                                              context, id);
                                                          log('This is uploade document id : $id');
                                                        } catch (e) {
                                                          log('Error is : $e');
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(0.0),
                                                        ),
                                                      ),
                                                      elevation: 5.0,
                                                      minWidth: 100.0,
                                                      height: 45,
                                                      color: mainColor,
                                                      child: InkWell(
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          // _isNeedHelp = true;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Create new lesson',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 4, 71, 125),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.edit,
                            ),
                            TextButton(
                              onPressed: () {
                                getCourseChaptersData();
                                addUnit(context);
                              },
                              child: const Text('add new unit'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.delete_forever,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      //width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                      ),
                                      child: AlertDialog(
                                        title: Container(
                                          //width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      40,
                                                    ),
                                                    color: greenShadeColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    size: 30,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                const Text(
                                                  'Are you sure?',
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                const Text(
                                                  'you want to delete the following unit?',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  id,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                    'all the lessons and resourses will be deleted along with all the student progress',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    MaterialButton(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(0.0),
                                                        ),
                                                      ),
                                                      elevation: 5.0,
                                                      minWidth: 80.0,
                                                      height: 45,
                                                      color: mainColor,
                                                      child: const Text(
                                                        'Yes,Delete Unit',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        course
                                                            .doc(
                                                                widget.courseId)
                                                            .collection(
                                                                'chapters')
                                                            .doc(id)
                                                            .update({
                                                          'status': 'delete'
                                                        });

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(0.0),
                                                        ),
                                                      ),
                                                      elevation: 5.0,
                                                      minWidth: 80.0,
                                                      height: 45,
                                                      color: greenShadeColor,
                                                      child: const Text(
                                                        'No',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.white),
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
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
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

  uploadlesson(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: AlertDialog(
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type == 'Document'
                            ? 'New Lesson(File)Details '
                            : type == "Video"
                                ? 'New Lesson(Video)Details '
                                : 'New Lesson(Audio)Details ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'LESSON NAME',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: lessonNameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Lesson',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 25, 0, 12),
                                child: Text(
                                  'LESSON DESCRIPTION',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: lessoneDescriptionController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Description',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 25, 0, 12),
                                child: Text(
                                  'WATERMARK POSITION',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: waterMarkPositionController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Watermark',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 25, 0, 12),
                                child: Text(
                                  'Duration',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: durationController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Duration of the Audio / Video',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 20,
                                ),
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.withOpacity(0.3),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: filename.isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.movie,
                                                size: 30,
                                                color: Colors.blue[900],
                                              ),
                                              Text(
                                                filename,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            type == "Document"
                                                ? "Pick Document by clicking below"
                                                : type == "Video"
                                                    ? "Pick Video by clicking below"
                                                    : "Pick Audio by clicking below",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  log('doc type is $type');

                                  if (type == "Document") {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'doc', 'docx'],
                                    );
                                    if (result == null) return;

                                    var selectedByte = result.files.first;
                                    log('file byte is ${selectedByte.name}');
                                    setState(() {
                                      webDoc = selectedByte.bytes!;
                                      filename = selectedByte.name;
                                      fileType = "Document";
                                      pickDocFileType = File('a');
                                    });
                                  } else if (type == "Video") {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.video,
                                    );
                                    if (result == null) return;

                                    var selectedByte = result.files.first;
                                    log('file byte is ${selectedByte.name}');
                                    setState(() {
                                      webVideo = selectedByte.bytes!;
                                      filename = selectedByte.name;
                                      fileType = "Video";
                                      pickVideoFileType = File('a');
                                    });
                                  } else {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.audio,
                                    );
                                    if (result == null) return;

                                    var selectedByte = result.files.first;
                                    log('file byte is ${selectedByte.name}');
                                    setState(() {
                                      webAudio = selectedByte.bytes!;
                                      filename = selectedByte.name;
                                      fileType = "Audio Book";
                                      pickAudioFileType = File('a');
                                    });
                                  }
                                },
                                child: Text(
                                  type == "Document"
                                      ? 'Upload New Document'
                                      : type == "Video"
                                          ? 'Upload New Video'
                                          : 'Upload New Audio',
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                ),
                              ),
                              showWarning
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Please fill all details to upload this course chapter data',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5.0,
                            minWidth: 70.0,
                            height: 42,
                            color: Colors.green,
                            child: const Text(
                              'SAVE',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                            onPressed: () {
                              if (lessonNameController.text.isNotEmpty &&
                                  lessoneDescriptionController
                                      .text.isNotEmpty &&
                                  durationController.text.isNotEmpty &&
                                  fileType!.isNotEmpty &&
                                  filename.isNotEmpty) {
                                try {
                                  type == "Document"
                                      ? uploadAnyFileFunction(
                                          FileType.custom, id)
                                      : type == "Video"
                                          ? uploadAnyFileFunction(
                                              FileType.video, id)
                                          : uploadAnyFileFunction(
                                              FileType.audio, id);
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircularProgressIndicator(
                                                  color: greenShadeColor,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                    'Uploading! Please wait...')
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                  log('This is uploade file document id : $id');
                                } catch (e) {
                                  log('Error is : $e');
                                }
                                setState(() {
                                  showWarning = false;
                                });
                              } else {
                                setState(() {
                                  showWarning = true;
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5.0,
                              minWidth: 70.0,
                              height: 42,
                              color: Colors.blue,
                              child: const Text(
                                'CLOSE',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  addText(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AlertDialog(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Lesson(Text)Details ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'LESSON NAME',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'name of lesson',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 12),
                            child: Text(
                              'PUBLISH LESSON',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        elevation: 5.0,
                        minWidth: 70.0,
                        height: 42,
                        color: Colors.green,
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const TextEditerPage(),
                          //   ),
                          // );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5.0,
                          minWidth: 70.0,
                          height: 42,
                          color: Colors.blue,
                          child: const Text(
                            'CLOSE',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
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
                            controller: chapterTitleController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Chapter Title',
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
                            controller: chapterDescriptionController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Chapter Description',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            getCourseChaptersData();
                            createChapter();
                            Navigator.pop(context);
                            chapterTitleController.clear();
                            chapterDescriptionController.clear();
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
                              color: Colors.black,
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
}
