import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/edit_course_info.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class ApproveCourseScreen extends StatefulWidget {
  final String courseId;
  const ApproveCourseScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<ApproveCourseScreen> createState() => _ApproveCourseScreenState();
}

class _ApproveCourseScreenState extends State<ApproveCourseScreen> {
  String courseName = '';
  String courseAuthorName = '';
  String courseLanguage = '';
  String courseDescription = '';
  String courseShortDescription = '';
  String courseDays = '';
  String studentLearn = '';
  String courseImage = '';
  String courseBaseAmmount = '';
  String courseGstRate = '';
  String courseDiscount = '';
  String courseIsLive = '';
  String courseUploadedBy = '';
  String courseValidity = '';
  String courseChaptersCount = '';

  Future getCourseData() async {
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .get()
        .then((value) {
      setState(() {
        courseName = value.get('name');
        courseAuthorName = value.get('author_name');
        courseLanguage = value.get('language');
        courseDescription = value.get('course_description');
        courseShortDescription = value.get('short_description');
        courseDays = value.get('validity');
        studentLearn = value.get('students_learn');
        courseImage = value.get('image');
        courseBaseAmmount = value.get('base_ammount');
        courseGstRate = value.get('gst_rate');
        courseDiscount = value.get('discount');
        courseIsLive = value.get('islive');
        courseUploadedBy = value.get('uploaded_by');
        courseValidity = value.get('validity');
        courseChaptersCount = value.get('chapters');
      });
    });
    log('data is ${widget.courseId} $courseImage $courseName $courseAuthorName');
  }

  @override
  void initState() {
    super.initState();
    getCourseData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: width / 2,
            height: height,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: greenShadeColor.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width / 2,
                  height: 200,
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
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              courseImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      courseName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        courseShortDescription,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.3),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: purpleColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: purpleColor.withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        courseBaseAmmount,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: greenShadeColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: mainColor.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditCourseInfo(
                                                courseId: widget.courseId,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 1,
                                        decoration: BoxDecoration(
                                          color: whiteColor.withOpacity(0.4),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UploadCoursesScreen(
                                                courseId: widget.courseId,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Chapters',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: purpleColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 1,
                                        decoration: BoxDecoration(
                                          color: whiteColor.withOpacity(0.4),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('courses')
                                              .doc(widget.courseId)
                                              .update({
                                            'status': 'delete',
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 32,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: courseIsLive == "false"
                                  ? mainColor
                                  : purpleColor,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  courseIsLive == "false"
                                      ? 'assets/file-icon.png'
                                      : 'assets/live-icon.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  courseIsLive == "false"
                                      ? "In Draft"
                                      : "Is Live",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: greenShadeColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Switch(
                              value: courseIsLive == "true" ? true : false,
                              activeColor: whiteColor,
                              activeTrackColor: Colors.black.withOpacity(0.3),
                              onChanged: (bool value) {
                                FirebaseFirestore.instance
                                    .collection('courses')
                                    .doc(widget.courseId)
                                    .update({
                                  'islive': '$value',
                                });
                                getCourseData();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        courseDetailsWidget(
                          'Course Name :',
                          courseName,
                        ),
                        courseDetailsWidget(
                          'Author Name :',
                          courseAuthorName,
                        ),
                        courseDetailsWidget(
                          'Base Amount :',
                          "Rs.$courseBaseAmmount",
                        ),
                        courseDetailsWidget(
                          'Discount :',
                          "$courseDiscount%",
                        ),
                        courseDetailsWidget(
                          'GST :',
                          "$courseGstRate%",
                        ),
                        courseDetailsWidget(
                          'Course Language :',
                          courseLanguage,
                        ),
                        courseDetailsWidget(
                          'course Description :',
                          courseDescription,
                        ),
                        courseDetailsWidget(
                          'course Short Description :',
                          courseShortDescription,
                        ),
                        courseDetailsWidget(
                          'Student Learn :',
                          studentLearn,
                        ),
                        courseDetailsWidget(
                          'Uploaded By :',
                          courseUploadedBy,
                        ),
                        courseDetailsWidget(
                          'Course Validity :',
                          courseValidity,
                        ),
                        courseDetailsWidget(
                          'Course Chapters :',
                          "$courseChaptersCount Chapters",
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('courses')
                            .doc(widget.courseId)
                            .update(
                          {
                            'status': 'rejected',
                            'islive': 'false',
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Reject This Course',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: purpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('courses')
                            .doc(widget.courseId)
                            .update(
                          {
                            'status': 'approved',
                            'islive': 'true',
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Approve This Course',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  courseDetailsWidget(label, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 300,
            child: Text(
              data,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
