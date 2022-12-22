// ignore_for_file: invalid_return_type_for_catch_error, unused_field

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:primeway_admin_panel/view/course_dashboard/text_editor.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:video_player/video_player.dart';

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

  String draft = 'Draft';
  String type = 'Audio Book';
  var items = [
    "Audio Book",
    "Rich Text",
    "Document",
    "Video",
    "eBook",
    "Mixed",
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

  Future<void> pickImage() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
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
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
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

  Future uploadFile(id) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('course/${widget.courseId}${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      log('done');
    }).catchError(
      (error) => log('something went wrong : $error'),
    );
    String url = await taskSnapshot.ref.getDownloadURL();
    try {
      await course
          .doc(widget.courseId)
          .collection('chapters')
          .doc(id)
          .collection('videos')
          .doc(lessonNameController.text)
          .set({
        'url': url.toString(),
        'type': type,
        'title': lessonNameController.text,
        'description': lessoneDescriptionController.text,
        'water_position': waterMarkPositionController.text,
        'duration': '',
      });
    } catch (e) {
      log('message is error : $e');
    }
  }

  late VideoPlayerController _controller;

  bool showControls = true;

  String videoTitle = '';
  String videoUrl = '';

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    getCourseChaptersData();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: displayHeight(context),
                    width: displayWidth(context) / 2,
                    child: ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          var tapIndex = 0;
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
                                key: Key(tapIndex.toString()),
                                title: Text("${documentSnapshot.id} $tapIndex"),
                                textColor: Colors.blue,
                                onExpansionChanged: (value) {
                                  setState(() {
                                    tapIndex = index;
                                    log('tap index is $tapIndex');
                                  });
                                },
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
                                                streamSnapshot
                                                    .data!.docs[index];
                                            videoUrl =
                                                documentSnapshotVideo['url'];
                                            videoTitle =
                                                documentSnapshotVideo['title'];
                                            return Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                height: 50,
                                                decoration:
                                                    const BoxDecoration(),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (documentSnapshotVideo[
                                                              'url']
                                                          .toString()
                                                          .contains('mp4')) {
                                                        _controller =
                                                            VideoPlayerController
                                                                .network(
                                                                    documentSnapshotVideo[
                                                                        'url'])
                                                              ..initialize()
                                                                  .then((_) {
                                                                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                                setState(() {});
                                                              });
                                                      }

                                                      videoTitle =
                                                          documentSnapshotVideo[
                                                              'title'];
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 30.0,
                                                    ),
                                                    child: documentSnapshotVideo[
                                                                'type'] ==
                                                            'Video'
                                                        ? Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.movie),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                              ),
                                                              Text(
                                                                documentSnapshotVideo
                                                                    .id,
                                                              ),
                                                            ],
                                                          )
                                                        : documentSnapshotVideo[
                                                                    'type'] ==
                                                                'Audio Book'
                                                            ? Row(
                                                                children: [
                                                                  const Icon(Icons
                                                                      .audiotrack),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                  ),
                                                                  Text(
                                                                    documentSnapshotVideo
                                                                        .id,
                                                                  ),
                                                                ],
                                                              )
                                                            : documentSnapshotVideo[
                                                                        'type'] ==
                                                                    'eBook'
                                                                ? Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .book),
                                                                      const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20),
                                                                      ),
                                                                      Text(
                                                                        documentSnapshotVideo
                                                                            .id,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : documentSnapshotVideo[
                                                                            'type'] ==
                                                                        'Rich Text'
                                                                    ? Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.text_snippet),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 20),
                                                                          ),
                                                                          Text(
                                                                            documentSnapshotVideo.id,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.not_interested_sharp),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 20),
                                                                          ),
                                                                          Text(
                                                                            documentSnapshotVideo.id,
                                                                          ),
                                                                        ],
                                                                      ),
                                                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.value.isInitialized
                          ? SizedBox(
                              height: 300,
                              width: displayWidth(context) / 3,
                              child: InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      showControls = !showControls;
                                    },
                                  );
                                },
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: Stack(
                                    children: [
                                      VideoPlayer(_controller),
                                      showControls
                                          ? Center(
                                              child: InkWell(
                                                onHover: (value) {
                                                  showControls = value;
                                                },
                                                onTap: () {
                                                  setState(() {
                                                    _controller.value.isPlaying
                                                        ? _controller.pause()
                                                        : _controller.play();
                                                    _controller.value.isPlaying
                                                        ? showControls = false
                                                        : showControls = true;
                                                  });
                                                },
                                                child: Icon(
                                                  _controller.value.isPlaying
                                                      ? Icons.pause_rounded
                                                      : Icons
                                                          .play_arrow_rounded,
                                                  size: 50,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      showControls
                                          ? Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      showControls
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 7,
                                                  horizontal: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child:
                                                          ValueListenableBuilder(
                                                        valueListenable:
                                                            _controller,
                                                        builder: (context,
                                                            VideoPlayerValue
                                                                value,
                                                            child) {
                                                          return Text(
                                                            _videoDuration(
                                                                value.position),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          VideoProgressIndicator(
                                                        _controller,
                                                        allowScrubbing: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        _videoDuration(
                                                            _controller.value
                                                                .duration),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 500,
                              width: 800,
                              child: Center(
                                child:
                                    Lottie.asset('assets/json/buffering.json'),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 10),
                        child: Text(
                          videoTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                height: 240,
                width: 300,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        onPressed: () {},
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
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Publish Unit',
                                style: TextStyle(
                                  color: Colors.blue,
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
                      type == 'Document'
                          ? Text(
                              'New Lesson(File)Details ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 23,
                              ),
                            )
                          : type == "Video"
                              ? Text(
                                  'New Lesson(Video)Details ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 23,
                                  ),
                                )
                              : type == "Audio Book"
                                  ? Text(
                                      'New Lesson(Audio)Details ',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 23,
                                      ),
                                    )
                                  : type == "Rich Text"
                                      ? addText(context, id)
                                      : Text(
                                          'New Lesson(URL)Details ',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
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
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: lessonNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'name of lesson',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 12),
                            child: Text(
                              'LESSON DESCRIPTION',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: lessoneDescriptionController,
                                maxLines: 5,
                                decoration:
                                    const InputDecoration(hintText: 'passw'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 12),
                            child: Text(
                              'WATERMARK POSITION',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: waterMarkPositionController,
                                maxLines: 5,
                                decoration:
                                    const InputDecoration(hintText: 'passw'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'Draft',
                                  groupValue: draft,
                                  onChanged: (value) {
                                    setState(() {
                                      draft = value.toString();
                                    });
                                  },
                                ),
                                const Text('DRAFT'),
                                const SizedBox(
                                  width: 55,
                                ),
                                Radio(
                                  value: 'Published',
                                  groupValue: draft,
                                  onChanged: (value) {
                                    setState(() {
                                      draft = value.toString();
                                    });
                                  },
                                ),
                                const Text('PUBLISHED'),
                              ],
                            ),
                          ),
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
                            ),
                          ),
                          type == "Document"
                              ? TextButton(
                                  onPressed: (() {
                                    pickImage();
                                  }),
                                  child: const Text(
                                    'Upload New Document',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                )
                              : type == "Video"
                                  ? TextButton(
                                      onPressed: (() {
                                        pickImage();
                                      }),
                                      child: const Text(
                                        'Upload New Video',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 15),
                                      ),
                                    )
                                  : type == "Audio Book"
                                      ? TextButton(
                                          onPressed: (() {
                                            pickImage();
                                          }),
                                          child: const Text(
                                            'Upload New Audio',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15),
                                          ),
                                        )
                                      : const Text(
                                          '',
                                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'You can upload Document, Video and Audio here',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14),
                            ),
                          ),
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
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        onPressed: () {
                          try {
                            uploadFile(id);
                            log('This is uploade file document id : $id');
                          } catch (e) {
                            log('Error is : $e');
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
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TextEditerPage(),
                            ),
                          );
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
