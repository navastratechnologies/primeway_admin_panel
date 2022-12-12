import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCourse extends StatefulWidget {
  final String courseName;
      // courseAuthorName,
      // courseRequiredPoint,
      // courseLanguage,
      // courseDescription,
      // courseShortDescription,
      // courseDate,
      // courseForWhom,
      // courseRequirement,
      // studentLearn,
      // courseBenefit
      
  const EditCourse(
      {super.key,
      required this.courseName,
      // required this.courseAuthorName,
      // required this.courseRequiredPoint,
      // required this.courseLanguage,
      // required this.courseDescription,
      // required this.courseShortDescription,
      // required this.courseDate,
      // required this.courseForWhom,
      // required this.courseRequirement,
      // required this.studentLearn,
      // required this.courseBenefit,
      });

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse>
    with AutomaticKeepAliveClientMixin {
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

  @override
  void initState() {
    courseNameController.text = widget.courseName;
    // courseAuthorNameController.text = widget.courseAuthorName;
    // coursePointsRequiredController.text = widget.courseRequiredPoint;
    // courseLanguageController.text = widget.courseLanguage;
    // courseDescriptionController.text = widget.courseDescription;
    // courseShortDescriptionController.text = widget.courseShortDescription;
    // courseDateController.text = widget.courseDate;
    // courseForWhomController.text = widget.courseForWhom;
    // courseRequirementsController.text = widget.courseRequirement;
    // studentLearnController.text = widget.studentLearn;
    // courseBenefitsController.text = widget.courseBenefit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
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
                              hintText: 'Points required to access course',
                            ),
                          ),
                        ],
                      ),
                    ),
                    () {
                      return SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('AVAILBILITY'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                              hintText: 'Description about the Course',
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
                            controller: courseShortDescriptionController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Short description about the Course',
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
                              hintText: 'Enter comma seperated sentences',
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
                              hintText: 'Enter comma seperated sentences',
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
                              hintText: 'Enter comma seperated sentences',
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
                              hintText: 'Enter comma seperated sentences',
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
                                  borderRadius: BorderRadius.circular(20),
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
                                  borderRadius: BorderRadius.circular(20),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
