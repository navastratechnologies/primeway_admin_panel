import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditComboInfo extends StatefulWidget {
  final String courseId;
  const EditComboInfo({super.key, required this.courseId});

  @override
  State<EditComboInfo> createState() => _EditComboInfoState();
}

class _EditComboInfoState extends State<EditComboInfo> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseAuthorNameController = TextEditingController();
  TextEditingController courseLanguageController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController courseShortDescriptionController =
      TextEditingController();
  TextEditingController courseDateController = TextEditingController();
  TextEditingController studentLearnController = TextEditingController();
  TextEditingController baseAmmountController = TextEditingController();
  TextEditingController gstRateController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  String draft = 'Draft';
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
        .collection('combos')
        .doc(widget.courseId)
        .update({
      'image': url.toString(),
      'name': courseNameController.text,
      'author_name': courseAuthorNameController.text,
      'publish_course': draft,
      'language': courseLanguageController.text,
      'course_description': courseDescriptionController.text,
      'short_description': courseShortDescriptionController.text,
      'validity': courseDateController.text,
      'students_learn': studentLearnController.text,
      'uploaded_by': 'Admin',
      'status': 'paused',
      'base_ammount': baseAmmountController.text,
      'gst_rate': gstRateController.text,
      'discount': discountController.text,
      'deleted_by': '',
      'islive': 'false',
      'Courses': courses
    });
  }

  String courseName = '';
  String courseAuthorName = '';
  String coursePublish = '';
  String courseLanguage = '';
  String courseDescription = '';
  String courseShortDescription = '';
  String courseDays = '';
  String studentLearn = '';
  String courseImage = '';
  String courseBaseAmmount = '';
  String courseGstRate = '';
  String courseDiscount = '';

  Future<void> getCourseData() async {
    await FirebaseFirestore.instance
        .collection('combos')
        .doc(widget.courseId)
        .get()
        .then((value) {
      courseName = value.get('name');
      courseAuthorName = value.get('author_name');
      coursePublish = value.get('publish_course');
      courseLanguage = value.get('language');
      courseDescription = value.get('course_description');
      courseShortDescription = value.get('short_description');
      courseDays = value.get('validity');
      studentLearn = value.get('students_learn');

      courseBaseAmmount = value.get('base_ammount');
      courseGstRate = value.get('gst_rate');
      courseDiscount = value.get('discount');
      courses.addAll(value.get('Courses'));
      log('courses : $courseImage');
      setState(() {
        courseNameController.text = courseName;
        courseAuthorNameController.text = courseAuthorName;
        draft = coursePublish;
        courseLanguageController.text = courseLanguage;
        courseDescriptionController.text = courseDescription;
        courseShortDescriptionController.text = courseShortDescription;
        courseDateController.text = courseDays;
        studentLearnController.text = studentLearn;
        baseAmmountController.text = courseBaseAmmount;
        gstRateController.text = courseGstRate;
        discountController.text = courseDiscount;
      });
    });
  }

  List courses = [];
  bool sc = false;

  Future updatestatus(String id, String status) async {
    FirebaseFirestore.instance
        .collection('courses')
        .doc(id)
        .update({'add_combo': status});
  }

  @override
  void initState() {
    getCourseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: const Text(
          'Edit Course Details',
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
              'Save',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              uploadFile();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ScreenTypeLayout(
          mobile: mobileBody(),
          desktop: desktopBody(),
        ),
      ),
    );
  }

  desktopBody() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldWithData(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: VerticalDivider(
                      thickness: 1.2,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  imageUploadData(),
                ],
              ),
              MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                elevation: 5.0,
                minWidth: 200.0,
                height: 45,
                color: purpleColor,
                child: const Text(
                  'Select courses',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    sc = true;
                  });
                },
              ),
            ],
          ),
        ),
        sc
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.21,
                    width: MediaQuery.of(context).size.width < 1500
                        ? 550
                        : MediaQuery.of(context).size.width / 3.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.6,
                              blurRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: purpleColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Selected Courses  ${courses.length}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      sc = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 35,
                                    color: purpleColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width / 2.3,
                              color: purpleColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.48,
                              width: MediaQuery.of(context).size.width < 1600
                                  ? MediaQuery.of(context).size.width / 1.5
                                  : MediaQuery.of(context).size.width / 3.1,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('courses')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamsnapshot) {
                                    if (streamsnapshot.hasData) {
                                      return ResponsiveGridList(
                                          horizontalGridSpacing:
                                              16, // Horizontal space between grid items

                                          horizontalGridMargin:
                                              0, // Horizontal space around the grid
                                          verticalGridMargin:
                                              0, // Vertical space around the grid
                                          minItemWidth:
                                              300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                          minItemsPerRow:
                                              1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                          maxItemsPerRow:
                                              1, // The maximum items to show in a single row. Can be useful on large screens

                                          listViewBuilderOptions:
                                              ListViewBuilderOptions(
                                                  shrinkWrap:
                                                      true), // Options that are getting passed to the ListView.builder() function
                                          children: List.generate(
                                              streamsnapshot.data!.docs.length,
                                              (index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamsnapshot
                                                    .data!.docs[index];
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (courses.contains(
                                                      documentSnapshot.id)) {
                                                    courses.remove(
                                                        documentSnapshot.id);

                                                    log('selected$courses');
                                                  } else {
                                                    courses.add(
                                                        documentSnapshot.id);

                                                    log('selected$courses');
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 21,
                                                        vertical: 7),
                                                child: Container(
                                                  height: 160,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                          color: courses.contains(
                                                                  documentSnapshot
                                                                      .id)
                                                              ? purpleColor
                                                              : Colors
                                                                  .transparent),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    102,
                                                                    100,
                                                                    100)
                                                                .withOpacity(
                                                                    0.4),
                                                            spreadRadius: 0.6,
                                                            blurRadius: 1)
                                                      ]),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0,
                                                                right: 20),
                                                        child: Container(
                                                          height: 160,
                                                          width: 130,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: ImageNetwork(
                                                            image:
                                                                documentSnapshot[
                                                                    'image'],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            imageCache:
                                                                CachedNetworkImageProvider(
                                                                    documentSnapshot[
                                                                        'image']),
                                                            height: 160,
                                                            width: 130,
                                                            fitWeb:
                                                                BoxFitWeb.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 300,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: 200,
                                                                  child: Text(
                                                                    documentSnapshot[
                                                                        'name'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.8),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  ('Rs.${documentSnapshot['base_ammount']}'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          SingleChildScrollView(
                                                            child: SizedBox(
                                                              width: 300,
                                                              height: 120,
                                                              child: Text(
                                                                documentSnapshot[
                                                                    'course_description'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
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
                                          }));
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: 1,
                width: 1,
                //color: Colors.white,
              )
      ],
    );
  }

  dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Container(
                height: 700,
                width: 500,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Select Courses=  ${courses.length}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: 500,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 645,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('courses')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                            if (streamsnapshot.hasData) {
                              return ResponsiveGridList(
                                  horizontalGridSpacing:
                                      16, // Horizontal space between grid items

                                  horizontalGridMargin:
                                      0, // Horizontal space around the grid
                                  verticalGridMargin:
                                      0, // Vertical space around the grid
                                  minItemWidth:
                                      300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                  minItemsPerRow:
                                      1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                  maxItemsPerRow:
                                      1, // The maximum items to show in a single row. Can be useful on large screens

                                  listViewBuilderOptions: ListViewBuilderOptions(
                                      shrinkWrap:
                                          true), // Options that are getting passed to the ListView.builder() function
                                  children: List.generate(
                                      streamsnapshot.data!.docs.length,
                                      (index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamsnapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: () {
                                        if (courses
                                            .contains(documentSnapshot.id)) {
                                          courses.remove(documentSnapshot.id);
                                          updatestatus(
                                              documentSnapshot.id, '0');
                                          log('selected$courses');
                                        } else {
                                          courses.add(documentSnapshot.id);
                                          updatestatus(
                                              documentSnapshot.id, '1');
                                          log('selected$courses');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 21),
                                        child: Container(
                                          height: 160,
                                          //width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: documentSnapshot[
                                                          'add_combo'] ==
                                                      '1'
                                                  ? Colors.green
                                                      .withOpacity(0.3)
                                                  : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color.fromARGB(
                                                            255, 102, 100, 100)
                                                        .withOpacity(0.1),
                                                    spreadRadius: 0.6,
                                                    blurRadius: 1)
                                              ]),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 20),
                                                child: Container(
                                                  height: 160,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: ImageNetwork(
                                                    image: documentSnapshot[
                                                        'image'],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    imageCache:
                                                        CachedNetworkImageProvider(
                                                            documentSnapshot[
                                                                'image']),
                                                    height: 160,
                                                    width: 130,
                                                    fitWeb: BoxFitWeb.cover,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            documentSnapshot[
                                                                'name'],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Text(
                                                          ('Rs.${documentSnapshot['base_ammount']}'),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SingleChildScrollView(
                                                    child: SizedBox(
                                                      width: 300,
                                                      height: 120,
                                                      child: Text(
                                                        documentSnapshot[
                                                            'course_description'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                  }));
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                  ],
                ),
              ));
        });
  }

  mobileBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageUploadData(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: VerticalDivider(
              thickness: 1.2,
              indent: 20,
              endIndent: 20,
              color: Colors.black.withOpacity(0.05),
            ),
          ),
          textFieldWithData(),
        ],
      ),
    );
  }

  imageUploadData() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            color: greenShadeColor,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                        height: 300,
                        width: 200,
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('combos')
                              .where('course_id', isEqualTo: widget.courseId)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              final List<
                                      QueryDocumentSnapshot<
                                          Map<String, dynamic>>> documents =
                                  streamSnapshot.data!.docs;

                              if (documents.isNotEmpty) {
                                final Map<String, dynamic> comboData =
                                    documents.first.data();
                                final String courseImage = comboData['image'];

                                return SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: ImageNetwork(
                                    image: courseImage,
                                    borderRadius: BorderRadius.circular(12),
                                    imageCache:
                                        CachedNetworkImageProvider(courseImage),
                                    height: 300,
                                    width: 200,
                                    fitWeb: BoxFitWeb.cover,
                                  ),
                                );
                              }
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: greenShadeColor,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Old Image',
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
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              pickImage();
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              color: greenShadeColor,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: pickedFile == null
                    ? SizedBox(
                        height: 200,
                        width: 300,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/upload_thumbnail.jpeg',
                              height: 200,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: greenShadeColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: mainColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.memory(
                          webImage,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Upload Course Thumbnail here.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  textFieldWithData() {
    return Expanded(
      child: ResponsiveGridList(
        horizontalGridSpacing: 30,
        horizontalGridMargin: 10,
        verticalGridMargin: 20,
        verticalGridSpacing: 30,
        minItemWidth: 200,
        maxItemsPerRow: 3,
        listViewBuilderOptions: ListViewBuilderOptions(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
        ),
        children: [
          textfieldWithLabelWidget(
            'Course Name',
            courseNameController,
            'Name of the Course',
          ),
          textfieldWithLabelWidget(
            'Author Name',
            courseAuthorNameController,
            'Name of the Author',
          ),
          textfieldWithLabelWidget(
            'Language',
            courseLanguageController,
            'Language of the Course',
          ),
          textfieldWithLabelWidget(
            'Description',
            courseDescriptionController,
            'Long Description of the Course',
          ),
          textfieldWithLabelWidget(
            'Short Description',
            courseShortDescriptionController,
            'Short Description of the Course',
          ),
          textfieldWithLabelWidget(
            'Valid Upto',
            courseDateController,
            'Valid Upto in Days',
          ),
          textfieldWithLabelWidget(
            'What will students learn ?',
            studentLearnController,
            'What will student learn from this course',
          ),
          textfieldWithLabelWidget(
            'base Amount',
            baseAmmountController,
            'Base amount of the Course',
          ),
          textfieldWithLabelWidget(
            'GST',
            gstRateController,
            'GST in Percentage',
          ),
          textfieldWithLabelWidget(
            'Discount',
            discountController,
            'Discount in Percentage',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publish Course ?',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
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
                  Text(
                    'Draft',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
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
                  Text(
                    'Published',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  textfieldWithLabelWidget(label, controller, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
