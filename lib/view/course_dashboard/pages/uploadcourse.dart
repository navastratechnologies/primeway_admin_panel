import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class UploadCoursesScreen extends StatefulWidget {
  final String courseId;
  const UploadCoursesScreen({super.key, required this.courseId});

  @override
  State<UploadCoursesScreen> createState() => _UploadCoursesScreenState();
}

class _UploadCoursesScreenState extends State<UploadCoursesScreen> {
  TextEditingController chapterTitleController = TextEditingController();
  TextEditingController chapterDescriptionController = TextEditingController();

  String draft = 'Draft';
  String type = 'Audio Book';
  var items = [
    "Audio Book",
    "Video",
    "eBook",
    "Mixed",
  ];

  final CollectionReference course =
      FirebaseFirestore.instance.collection('courses');

  Future<void> createChapter() async {
    course
        .doc(widget.courseId)
        .collection('chapters')
        .doc(chapterTitleController.text)
        .set({
      'title': chapterTitleController.text,
      'description': chapterDescriptionController.text,
      'publish_unit': draft,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1000,
        // height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Container(
                        height: 50,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey),
                          color: greenLightShadeColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            //obscureText: true,
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: 'Search Unit',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      elevation: 5.0,
                      minWidth: 150.0,
                      height: 50,
                      color: mainColor,
                      child: const Text(
                        '+ New Unit',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      onPressed: () {
                        addUnit(context);
                      },
                    ),
                  ],
                ),
                Container(height: 1, width: 850, color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 800,
                      // height: 50,
                      child: StreamBuilder(
                        stream: course
                            .doc(widget.courseId)
                            .collection('chapters')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ExpansionTile(
                                    title: Text(documentSnapshot.id),
                                    textColor: Colors.blue,
                                    trailing: InkWell(
                                      onTap: () {
                                        course
                                            .doc(widget.courseId)
                                            .collection('chapters')
                                            .doc(documentSnapshot.id)
                                            .delete();
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                    children: <Widget>[
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
                                              itemCount: streamSnapshot
                                                  .data!.docs.length,
                                              itemBuilder: (context, index) {
                                                final DocumentSnapshot
                                                    documentSnapshot =
                                                    streamSnapshot
                                                        .data!.docs[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: InkWell(
                                                      onTap: () {
                                                        try {
                                                          documentSnapshot[
                                                              'url'];
                                                          log('url is work : ${documentSnapshot['url']}');
                                                        } catch (e) {
                                                          log('url is : $e');
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 30.0,
                                                        ),
                                                        child: documentSnapshot[
                                                                    'type'] ==
                                                                'Video'
                                                            ? Row(
                                                                children: [
                                                                  const Icon(Icons
                                                                      .movie),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                  ),
                                                                  Text(
                                                                    documentSnapshot
                                                                        .id,
                                                                  ),
                                                                ],
                                                              )
                                                            : documentSnapshot[
                                                                        'type'] ==
                                                                    'Audio Book'
                                                                ? Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .audiotrack),
                                                                      const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20),
                                                                      ),
                                                                      Text(
                                                                        documentSnapshot
                                                                            .id,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : documentSnapshot[
                                                                            'type'] ==
                                                                        'eBook'
                                                                    ? Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.book),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 20),
                                                                          ),
                                                                          Text(
                                                                            documentSnapshot.id,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : documentSnapshot['type'] ==
                                                                            'Rich Text'
                                                                        ? Row(
                                                                            children: [
                                                                              const Icon(Icons.text_snippet),
                                                                              const Padding(
                                                                                padding: EdgeInsets.only(left: 20),
                                                                              ),
                                                                              Text(
                                                                                documentSnapshot.id,
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Row(
                                                                            children: [
                                                                              const Icon(Icons.not_interested_sharp),
                                                                              const Padding(
                                                                                padding: EdgeInsets.only(left: 20),
                                                                              ),
                                                                              Text(
                                                                                documentSnapshot.id,
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
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      //tooltip: 'Increase volume by 10',
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: AlertDialog(
                                                      title: Container(
                                                        //width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          30),
                                                              child: Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40),
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                            const Text(
                                                              'Lesson Type',
                                                              style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          20),
                                                              child:
                                                                  DropdownButtonFormField(
                                                                decoration:
                                                                    const InputDecoration(),
                                                                value: type,
                                                                items: items
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        items,
                                                                    child: Text(
                                                                        items),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  setState(() {
                                                                    type =
                                                                        newValue!;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                MaterialButton(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          0.0),
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      5.0,
                                                                  minWidth:
                                                                      100.0,
                                                                  height: 45,
                                                                  color: Colors
                                                                      .green,
                                                                  child:
                                                                      const Text(
                                                                    'Create Lesson',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      // _isNeedHelp = true;
                                                                    });
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
                                                                MaterialButton(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          0.0),
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      5.0,
                                                                  minWidth:
                                                                      100.0,
                                                                  height: 45,
                                                                  color: Colors
                                                                      .red,
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator
                                                                          .pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      // _isNeedHelp = true;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
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
                                                color: Color.fromARGB(
                                                    255, 4, 71, 125),
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: AlertDialog(
                                                      title: Container(
                                                        //width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 80,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  40,
                                                                ),
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            const Text(
                                                              'Are you sure?',
                                                              style: TextStyle(
                                                                fontSize: 30.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            const Text(
                                                              'you want to delete the following unit?',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            const Text(
                                                              'Discussion & user Management',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .black),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          0.0),
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      5.0,
                                                                  minWidth:
                                                                      80.0,
                                                                  height: 45,
                                                                  color: Colors
                                                                      .green,
                                                                  child:
                                                                      const Text(
                                                                    'Yes,Delete Unit',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      // _isNeedHelp = true;
                                                                    });
                                                                  },
                                                                ),
                                                                MaterialButton(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          0.0),
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      5.0,
                                                                  minWidth:
                                                                      80.0,
                                                                  height: 45,
                                                                  color: Colors
                                                                      .red,
                                                                  child:
                                                                      const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      // _isNeedHelp = true;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
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
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Container(height: 1, width: 850, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addUnit(BuildContext context) {
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        TextField(
                          controller: chapterTitleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title of the Unit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Unit Description',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextField(
                            controller: chapterDescriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Brief Description about the Unit',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Publish Unit?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'Draft',
                                  groupValue: draft,
                                  onChanged: (newValue) {
                                    setState(() {
                                      draft = newValue.toString();
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
                                  onChanged: (newValue) {
                                    try {
                                      setState(() {
                                        draft = newValue.toString();
                                        log('value is $draft');
                                      });
                                    } catch (e) {
                                      log('value is not change : $e');
                                    }
                                  },
                                ),
                                const Text('PUBLISHED'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                                createChapter();
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                              elevation: 5.0,
                              minWidth: 80.0,
                              height: 45,
                              color: Colors.grey,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
