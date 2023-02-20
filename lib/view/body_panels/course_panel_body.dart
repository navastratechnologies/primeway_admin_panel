import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

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

  String searchId = '';
  TextEditingController searchController = TextEditingController();

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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayWidth(context) < 600 || displayWidth(context) < 1200
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    mainBody(),
                    secondaryBody(context),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mainBody(),
                  secondaryBody(context),
                ],
              ),
      ),
    );
  }

  secondaryBody(BuildContext context) {
    return SizedBox(
      width: displayWidth(context) < 600 || displayWidth(context) < 1200
          ? displayWidth(context)
          : displayWidth(context) / 6,
      child: Container(
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
              child: SelectableText(
                "Update :-",
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height:
                  displayWidth(context) < 600 || displayWidth(context) < 1200
                      ? null
                      : displayHeight(context) / 1.3,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('notifications')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      shrinkWrap: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? true
                          : false,
                      physics: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  documentSnapshot['pic'],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: displayWidth(context) < 600 ||
                                            displayWidth(context) < 1200
                                        ? displayWidth(context) / 2
                                        : displayWidth(context) / 9,
                                    child: SelectableText.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "${documentSnapshot['name']} ",
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: documentSnapshot['message'],
                                            style: TextStyle(
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SelectableText(
                                    documentSnapshot['date_time'],
                                    style: TextStyle(
                                      color: whiteColor.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  mainBody() {
    return Container(
      width: displayWidth(context) < 600 || displayWidth(context) < 1200
          ? displayWidth(context)
          : displayWidth(context) / 1.5,
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridList(
            horizontalGridSpacing: 10,
            minItemWidth:
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? 200
                    : 300,
            listViewBuilderOptions: ListViewBuilderOptions(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            children: [
              dashboardTile(
                'users',
                'Users',
                FontAwesomeIcons.book,
              ),
              dashboardTile(
                'courses',
                'Courses',
                FontAwesomeIcons.bookOpenReader,
              ),
              dashboardTile(
                'collaboration',
                'Collaborations',
                FontAwesomeIcons.bookJournalWhills,
              ),
              dashboardTile(
                'affilate_dashboard',
                'Affiliate Users',
                FontAwesomeIcons.bookSkull,
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? displayWidth(context)
                : displayWidth(context) / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            'Courses List :-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          Container(
                            width: 400,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchId = searchController.text;
                                });
                              },
                              onEditingComplete: () {
                                setState(() {
                                  searchId = searchController.text;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter course id to search',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                adminTabel(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  adminTabel(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: purpleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'Courses List :-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchId = searchController.text;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              searchId = searchController.text;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter course id to search',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Center(
                          child: SelectableText(
                            "Course Id",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Center(
                          child: SelectableText(
                            "Course name",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Center(
                          child: SelectableText(
                            "Views",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Center(
                          child: SelectableText(
                            "Purchases",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Center(
                          child: SelectableText(
                            "Uploaded By",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Center(
                          child: SelectableText(
                            "Status",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.65,
            child: StreamBuilder(
                stream: searchController.text.isEmpty
                    ? courses.snapshots()
                    : courses
                        .where(
                          'course_id',
                          isEqualTo: searchId,
                        )
                        .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? true
                          : false,
                      physics: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: displayWidth(context) < 600 ||
                                  displayWidth(context) < 1200
                              ? Column(
                                  children: [
                                    ExpansionTile(
                                      childrenPadding: const EdgeInsets.all(10),
                                      tilePadding: const EdgeInsets.all(6),
                                      title: SelectableText(
                                        documentSnapshot['course_id'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      children: [
                                        expansionTableData(
                                          'Course Name',
                                          documentSnapshot['name'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Views',
                                          documentSnapshot['views'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Purchases',
                                          documentSnapshot['purchases'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Uploaded By',
                                          documentSnapshot['uploaded_by'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Status',
                                          documentSnapshot['status'],
                                          context,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    const Divider(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['course_id'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['name'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['views'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['purchases'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['uploaded_by'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: documentSnapshot[
                                                            'status'] ==
                                                        'approved'
                                                    ? greenLightShadeColor
                                                    : mainShadeColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: SelectableText(
                                                documentSnapshot['status'] ==
                                                        'approved'
                                                    ? "Approved"
                                                    : "Pending",
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
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
    );
  }

  dashboardTile(stream, title, icon) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        if (value) {
          setState(
            () {},
          );
        }
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: stream == 'affilate_dashboard'
                      ? FirebaseFirestore.instance
                          .collection(stream)
                          .doc('NkcdMPSuI3SSIpJ2uLuv')
                          .collection('affiliate_users')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection(stream)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return SelectableText(
                        streamSnapshot.data!.docs.length.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return SelectableText(
                      '0',
                      style: TextStyle(
                        fontSize: 50,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 120,
                  child: SelectableText(
                    title,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              color: greenLightShadeColor,
              size: displayWidth(context) < 1200 ? 80 : 120,
            ),
          ],
        ),
      ),
    );
  }
}
