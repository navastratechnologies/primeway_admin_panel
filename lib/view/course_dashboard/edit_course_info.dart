// ignore_for_file: invalid_return_type_for_catch_error
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../helpers/app_constants.dart';

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

  File? pickedFile;
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
      'views': '',
      'purchases': '',
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
      'deleted_by': '',
      'islive': 'false',
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
    try {
      setState(() {
        courseName = courseNameController.text;
      });
      log('This is working : ${courseNameController.text}');
    } catch (e) {
      log('This is not working : $e');
    }

    getCourseData();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 550,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 600,
                          width: 300,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'COURSE NAME',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextField(
                                      controller: courseNameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'name of courses',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'AUTHOR NAME',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextField(
                                      controller: courseAuthorNameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Name of the Course Author',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'COURSE TYPE',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 300,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(),
                                        value: type,
                                        items: courseType.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            type = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'REQUIRED POINTS',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Points required to access course',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              () {
                                return SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('AVAILBILITY'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'Register User',
                                            groupValue: available,
                                            onChanged: (value) {
                                              setState(() {
                                                available = value.toString();
                                              });
                                            },
                                          ),
                                          const Text('Register User'),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Radio(
                                            value: 'Public',
                                            groupValue: available,
                                            onChanged: (value) {
                                              setState(() {
                                                available = value.toString();
                                              });
                                            },
                                          ),
                                          const Text('Public'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('PUBLISH COURSE ?'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                    ],
                                  ),
                                );
                              }(),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isFeatured,
                                    onChanged: (value) {
                                      setState(() {
                                        isFeatured = true;
                                      });
                                    },
                                  ),
                                  const Text('IS FEATURED'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'COURSE LANGUAGE',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextField(
                                    controller: courseLanguageController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Language of the Course',
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
                                    'COURSE DESCRIPTION',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: courseDescriptionController,
                                      decoration: const InputDecoration(
                                        hintText:
                                            'Description about the Course',
                                        border: OutlineInputBorder(),
                                      ),
                                      maxLines: 6,
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
                                    'SHORT DESCRIPTION',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 300,
                                    child: TextField(
                                      controller:
                                          courseShortDescriptionController,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Short description about the Course',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: TextField(
                                      controller: courseDateController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Days',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'COURSE FOR WHOM ?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 300,
                                    child: TextField(
                                      controller: courseForWhomController,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter comma seperated sentences',
                                      ),
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
                                    'COURSE REQUIREMENTS',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 300,
                                    child: TextField(
                                      controller: courseRequirementsController,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter comma seperated sentences',
                                      ),
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
                                    'WHAT WILL STUDENTS LEARN ?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 300,
                                    child: TextField(
                                      controller: studentLearnController,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter comma seperated sentences',
                                      ),
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
                                    'COURSE BENEFITS',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 300,
                                    child: TextField(
                                      controller: courseBenefitsController,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter comma seperated sentences',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // available()
                          ],
                        ),
                        Container(
                          height: 700,
                          width: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Column(
                            children: [
                              pickedFile == null
                                  ? Container(
                                      height: 180,
                                      width: 220,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Image.asset('assets/capture.png'),
                                    )
                                  : kIsWeb
                                      ? Container(
                                          height: 180,
                                          width: 220,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Image.memory(webImage),
                                        )
                                      : Container(
                                          height: 180,
                                          width: 220,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Image.file(pickedFile!),
                                        ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: const Text(
                                  'UPLOAD PHOTO HERE',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ResponsiveGridList(
                      horizontalGridSpacing: 16,
                      horizontalGridMargin: 10,
                      verticalGridMargin: 50,
                      minItemWidth: 300,
                      minItemsPerRow: 4,
                      maxItemsPerRow: 4,
                      listViewBuilderOptions: ListViewBuilderOptions(),
                      children: [
                        TextField(
                          controller: baseAmmountController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'BASE AMOUNT',
                          ),
                        ),
                        TextField(
                          controller: gstAmmountController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'GST AMOUNT',
                          ),
                        ),
                        TextField(
                          controller: cgstAmmountController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CGST AMOUNT',
                          ),
                        ),
                        TextField(
                          controller: sgstAmmountController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'SGST AMOUNT',
                          ),
                        ),
                        TextField(
                          controller: gstRateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'GST RATE',
                          ),
                        ),
                        TextField(
                          controller: cgstRateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CGST RATE',
                          ),
                        ),
                        TextField(
                          controller: sgstRateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'SGST RATE',
                          ),
                        ),
                        TextField(
                          controller: netAmmountCountroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'NET AMOUNT',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
