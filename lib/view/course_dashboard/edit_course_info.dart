// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/edit_course.dart';

import '../helpers/app_constants.dart';
import 'edit_course_price.dart';

class EditCourseInfo extends StatefulWidget {
  final String courseId;
  const EditCourseInfo({super.key, required this.courseId});

  @override
  State<EditCourseInfo> createState() => _EditCourseInfoState();
}

class _EditCourseInfoState extends State<EditCourseInfo>
    with SingleTickerProviderStateMixin<EditCourseInfo> {
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

    FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .update({
      'image': url.toString(),
      'name': courseNameController.text,
      'author_name': courseAuthorNameController.text,
      'course_type': type,
      'required_points': coursePointsRequiredController.text,
      'availbility': available,
      'publish_course': draft,
      'is_featured': isFeatured,
      'language': courseLanguageController.text,
      'course_description': courseDescriptionController.text,
      'short_description': courseShortDescriptionController.text,
      'validity': courseDateController.text,
      'course_for_whom': courseForWhomController.text,
      'course_requirements': courseRequirementsController.text,
      'students_learn': studentLearnController.text,
      'course_benefits': courseBenefitsController.text,
      'views': 0,
      'purchases': 0,
      'uploaded_by': 'Admin',
      'status': 'paused',
      'base_ammount': baseAmmountController.text,
      'gst_ammount': gstAmmountController.text,
      'gst_rate': gstRateController.text,
      'cgst_ammount': cgstAmmountController.text,
      'cgst_rate': cgstRateController.text,
      'sgst_ammount': sgstAmmountController.text,
      'sgst_rate': sgstRateController.text,
      'net_ammount': netAmmountCountroller.text,
    });
  }

  String courseName = '';
  String courseAuthorName = '';
  String courseTypes = '';
  String coursePoints = '';
  String courseAvailbility = '';
  String coursePublish = '';
  bool? courseIsFeatured;
  String courseLanguage = '';
  String courseDescription = '';
  String courseShortDescription = '';
  String courseDays = '';
  String courseForWhom = '';
  String courseRequirements = '';
  String studentLearn = '';
  String courseBenefits = '';
  String courseImage = '';
  String courseBaseAmmount = '';
  String courseGstAmmount = '';
  String courseGstRate = '';
  String courseCgstAmmount = '';
  String courseCgstRate = '';
  String courseSgstAmmount = '';
  String courseSgstRate = '';
  String courseNetAmmount = '';

  Future<void> getCourseData() async {
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      try {
        setState(() {
          courseName = documentSnapshot.get('name');
          courseAuthorName = documentSnapshot.get('author_name');
          courseTypes = documentSnapshot.get('course_type');
          coursePoints = documentSnapshot.get('required_points');
          courseAvailbility = documentSnapshot.get('availbility');
          coursePublish = documentSnapshot.get('publish_course');
          courseIsFeatured = documentSnapshot.get('is_featured');
          courseLanguage = documentSnapshot.get('language');
          courseDescription = documentSnapshot.get('course_description');
          courseShortDescription = documentSnapshot.get('short_description');
          courseDays = documentSnapshot.get('validity');
          courseForWhom = documentSnapshot.get('course_for_whom');
          courseRequirements = documentSnapshot.get('course_requirements');
          studentLearn = documentSnapshot.get('students_learn');
          courseBenefits = documentSnapshot.get('course_benefits');
          courseImage = documentSnapshot.get('image');
          courseBaseAmmount = documentSnapshot.get('base_ammount');
          courseGstAmmount = documentSnapshot.get('gst_ammount');
          courseGstRate = documentSnapshot.get('gst_rate');
          courseCgstAmmount = documentSnapshot.get('cgst_ammount');
          courseCgstRate = documentSnapshot.get('cgst_rate');
          courseSgstAmmount = documentSnapshot.get('sgst_ammount');
          courseSgstRate = documentSnapshot.get('sgst_rate');
          courseNetAmmount = documentSnapshot.get('net_ammount');
          log('course name is : $courseName');
        });
      } catch (e) {
        log('edit course data error : $e');
      }
    });
  }

  @override
  void initState() {
    getCourseData();
    courseNameController.text = courseName;
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
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              uploadFile();
              Navigator.pop(context);
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
              children: [
                EditCourse(
                  // courseAuthorName: courseAuthorName,
                  // courseBenefit: courseBenefits,
                  // courseDate: courseDays,
                  // courseDescription: courseDescription,
                  // courseForWhom: courseForWhom,
                  // courseLanguage: courseLanguage,
                  courseName: courseName,
                  // courseRequiredPoint: coursePoints,
                  // courseRequirement: courseRequirements,
                  // courseShortDescription: courseShortDescription,
                  // studentLearn: studentLearn
                ),
                const EditCoursePrice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
