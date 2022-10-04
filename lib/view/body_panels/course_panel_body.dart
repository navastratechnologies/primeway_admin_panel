import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class CoursePanelBody extends StatefulWidget {
  const CoursePanelBody({super.key});

  @override
  State<CoursePanelBody> createState() => _CoursePanelBodyState();
}

class _CoursePanelBodyState extends State<CoursePanelBody> {
  String coursesCount = '';
  String approvedCourses = '';
  String unapprovedCourses = '';
  String rejectedCourses = '';

  final CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> getCoursesCount() async {
    FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((QuerySnapshot snapshot) {
      log('courses id is ${snapshot.docs.length}');
      setState(() {
        coursesCount = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> unapprovedCoursesCount() async {
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'unapproved')
        .get()
        .then((QuerySnapshot snapshot) {
      log('unapproved courses is ${snapshot.docs.length}');
      setState(() {
        unapprovedCourses = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> approvedCoursesCount() async {
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'approved')
        .get()
        .then((QuerySnapshot snapshot) {
      log('approved courses is ${snapshot.docs.length}');
      setState(() {
        approvedCourses = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> rejectedCoursesCount() async {
    FirebaseFirestore.instance
        .collection('courses')
        .where('status', isEqualTo: 'rejected')
        .get()
        .then((QuerySnapshot snapshot) {
      log('rejected courses is ${snapshot.docs.length}');
      setState(() {
        rejectedCourses = '${snapshot.docs.length}';
      });
    });
  }

  @override
  void initState() {
    getCoursesCount();
    approvedCoursesCount();
    unapprovedCoursesCount();
    rejectedCoursesCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        children: [
          SizedBox(
            width: displayWidth(context) / 1.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dashboardTile(
                  coursesCount,
                  'Live Courses',
                  FontAwesomeIcons.book,
                ),
                dashboardTile(
                  unapprovedCourses,
                  'Un-Approved Courses',
                  FontAwesomeIcons.bookOpenReader,
                ),
                dashboardTile(
                  approvedCourses,
                  'Approved Courses',
                  FontAwesomeIcons.bookJournalWhills,
                ),
                dashboardTile(
                  rejectedCourses,
                  'Rejected Courses',
                  FontAwesomeIcons.bookSkull,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: displayWidth(context) / 5,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: elevationColor,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          "Course Update :-",
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1546410531-bb4caa6b424d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: displayWidth(context) / 7,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'App Development Course',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' recently purchased by Username.',
                                          style: TextStyle(
                                            color: whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '24 hours ago.',
                                  style: TextStyle(
                                    color: whiteColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1546410531-bb4caa6b424d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: displayWidth(context) / 7,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'App Development Course',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' recently purchased by Username.',
                                          style: TextStyle(
                                            color: whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '24 hours ago.',
                                  style: TextStyle(
                                    color: whiteColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1546410531-bb4caa6b424d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: displayWidth(context) / 7,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'App Development Course',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' recently purchased by Username.',
                                          style: TextStyle(
                                            color: whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '24 hours ago.',
                                  style: TextStyle(
                                    color: whiteColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Courses List :-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: elevationColor,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: SizedBox(
                              width: displayWidth(context) / 2,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        "Course Id",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Course Name",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Views",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Purchases",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Uploaded By",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: displayHeight(context) / 2.3,
                            width: displayWidth(context) / 1.9,
                            child: StreamBuilder(
                                stream: courses.snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot>
                                        streamSnapshot) {
                                  if (streamSnapshot.hasData) {
                                    return ListView.builder(
                                      itemCount:
                                          streamSnapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            streamSnapshot.data!.docs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "${index.toString()}. ",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child: Text(
                                                        documentSnapshot[
                                                            'name'],
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child: Text(
                                                        documentSnapshot[
                                                            'views'],
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child: Text(
                                                        documentSnapshot[
                                                            'purchases'],
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child: Text(
                                                        documentSnapshot[
                                                            'uploaded_by'],
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: documentSnapshot[
                                                                      'status'] ==
                                                                  'approved'
                                                              ? greenLightShadeColor
                                                              : documentSnapshot[
                                                                          'status'] ==
                                                                      'rejected'
                                                                  ? yellow
                                                                  : documentSnapshot[
                                                                              'status'] ==
                                                                          'delete'
                                                                      ? orange
                                                                      : documentSnapshot['status'] ==
                                                                              'live'
                                                                          ? greenLightShadeColor
                                                                          : mainShadeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          documentSnapshot[
                                                                      'status'] ==
                                                                  'approved'
                                                              ? "Approved"
                                                              : documentSnapshot[
                                                                          'status'] ==
                                                                      'rejected'
                                                                  ? "Rejected"
                                                                  : documentSnapshot[
                                                                              'status'] ==
                                                                          'delete'
                                                                      ? "Delete"
                                                                      : documentSnapshot['status'] ==
                                                                              'live'
                                                                          ? "Live"
                                                                          : "Panding",
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dashboardTile(count, title, icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: greenShadeColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greenLightShadeColor,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 50,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FaIcon(
              icon,
              color: greenLightShadeColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
