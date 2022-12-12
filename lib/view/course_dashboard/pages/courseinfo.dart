// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courseinfo2.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/coursesprice.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class CoursesInfo extends StatefulWidget {
  final String courseName;
  final String courseAuthorName;
  final String coursePoint;
  final String courseLanguage;
  final String courseDescription;
  final String courseShortDescription;
  final String courseDate;
  final String courseForWhom;
  final String courseReqirement;
  final String studentLearn;
  final String courseBenefits;
  final String baseAmmount;
  final String gstAmmount;
  final String cgstAmmount;
  final String sgstAmmount;
  final String gstRate;
  final String cgstRate;
  final String sgstRate;
  final String netAmmount;

  const CoursesInfo(
      {super.key,
      required this.courseName,
      required this.courseAuthorName,
      required this.coursePoint,
      required this.courseLanguage,
      required this.courseDescription,
      required this.courseShortDescription,
      required this.courseDate,
      required this.courseForWhom,
      required this.courseReqirement,
      required this.studentLearn,
      required this.courseBenefits,
      required this.baseAmmount,
      required this.gstAmmount,
      required this.cgstAmmount,
      required this.sgstAmmount,
      required this.gstRate,
      required this.cgstRate,
      required this.sgstRate,
      required this.netAmmount});

  @override
  State<CoursesInfo> createState() => _CoursesInfoState();
}

class _CoursesInfoState extends State<CoursesInfo>
    with SingleTickerProviderStateMixin<CoursesInfo> {
  late TabController tabController;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseAuthorNameController = TextEditingController();
  TextEditingController coursePointsRequiredController =
      TextEditingController();
  TextEditingController courseLanguageController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController courseShortDescriptionController =
      TextEditingController();
  TextEditingController courseDateController = TextEditingController();
  TextEditingController courseForWhomController = TextEditingController();
  TextEditingController courseRequirementsController = TextEditingController();
  TextEditingController studentLearnController = TextEditingController();
  TextEditingController courseBenefitsController = TextEditingController();
  TextEditingController baseAmmountController = TextEditingController();
  TextEditingController gstAmmountController = TextEditingController();
  TextEditingController cgstAmmountController = TextEditingController();
  TextEditingController sgstAmmountController = TextEditingController();
  TextEditingController gstRateController = TextEditingController();
  TextEditingController cgstRateController = TextEditingController();
  TextEditingController sgstRateController = TextEditingController();
  TextEditingController netAmmountCountroller = TextEditingController();

  String available = 'Register User';
  String draft = 'Draft';
  String type = 'Audio Book';
  bool isFeatured = false;
  var courseType = [
    "Audio Book",
    "Video",
    "eBook",
    "Mixed",
  ];

  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);

  Future uploadFile() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('course/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
          () => log('done'),
        )
        .catchError(
          (error) => log('something went wrong'),
        );
    String url = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance.collection('courses').add({
      'image': url.toString(),
      'name': widget.courseName,
      'author_name': widget.courseAuthorName,
      'course_type': type,
      'required_points': widget.courseReqirement,
      'availbility': available,
      'publish_course': draft,
      'is_featured': isFeatured,
      'language': widget.courseLanguage,
      'course_description': widget.courseDescription,
      'short_description': widget.courseShortDescription,
      'validity': widget.courseDate,
      'course_for_whom': widget.courseForWhom,
      'course_requirements': widget.courseReqirement,
      'students_learn': widget.studentLearn,
      'course_benefits': widget.courseBenefits,
      'views': 0,
      'purchases': 0,
      'uploaded_by': 'Admin',
      'status': 'paused',
      'base_ammount': widget.baseAmmount,
      'gst_ammount': widget.gstAmmount,
      'gst_rate': widget.gstRate,
      'cgst_ammount': widget.cgstAmmount,
      'cgst_rate': widget.cgstRate,
      'sgst_ammount': widget.sgstAmmount,
      'sgst_rate': widget.sgstRate,
      'net_ammount': widget.netAmmount,
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'New Course Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          MaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            elevation: 5.0,
            minWidth: 200.0,
            height: 45,
            color: greenShadeColor,
            //hoverColor: mainColor,
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              uploadFile();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: tabController,
                        indicatorColor: mainColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text(
                              'Course Detail',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: greenShadeColor,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Course Price',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: greenShadeColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: TabBarView(
              controller: tabController,
              children: const [
                CourseInfo2(),
                CoursesPrice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
