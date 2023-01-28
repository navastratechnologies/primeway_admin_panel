// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

const List<String> list = <String>['paid', 'Barter'];

class collaborationDetailsscreen extends StatefulWidget {
  const collaborationDetailsscreen({
    super.key,
  });

  @override
  State<collaborationDetailsscreen> createState() =>
      _collaborationDetailsscreenState();
}

class _collaborationDetailsscreenState
    extends State<collaborationDetailsscreen> {
  bool addguidline = false;
  bool adddeliverable = false;
  String dropdownValue = list.first;
  TextEditingController titleNameController = TextEditingController();
  TextEditingController requiredfollowerfromController =
      TextEditingController();
  TextEditingController requiredfollowertoController = TextEditingController();
  TextEditingController collaborationDescriptionController =
      TextEditingController();
  TextEditingController collaborationtypediscription = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController collaborationtype = TextEditingController(text: "paid");
  TextEditingController categories = TextEditingController();
  TextEditingController additionalrequirement = TextEditingController();
  String logoimage = "";
  String logo = "";
  String dmimage = "";
  String draft = 'Draft';
  int total = 0;
  Uint8List webImage = Uint8List(8);
  Uint8List webImagelogoimage = Uint8List(8);
  Uint8List webImagelogo = Uint8List(8);
  File? pickedFile;
  File? pickedlogoimage;
  File? pickedlogo;

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

  Future<void> pickImagebrand() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          pickedlogo = selected;
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
          webImagelogo = selectedByte;
          pickedlogo = File('a');
        });
      } else {
        log('no image has been selected');
      }
    } else {
      log('something went wrong');
    }
  }

  Future<void> pickImagelogo() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          pickedlogoimage = selected;
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
          webImagelogoimage = selectedByte;
          pickedlogoimage = File('a');
        });
      } else {
        log('no image has been selected');
      }
    } else {
      log('something went wrong');
    }
  }

  Future uploadlogo() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('course/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImagelogo,
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

    logo = url;
    uploadFile();
  }

  Future uploadlogoimage() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('course/${DateTime.now()}.png');

    UploadTask uploadTask = ref.putData(
      webImagelogoimage,
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

    logoimage = url;
    uploadlogo();
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

    FirebaseFirestore.instance.collection('collaboration').add({
      'image': url.toString(),
      'brand_logo': logo,
      'categories': categories.text,
      'collaboration_type': collaborationtype.text,
      'collaboration_type_discription': collaborationtypediscription.text,
      'descreption': collaborationDescriptionController.text,
      'language': languageController.text,
      'logo': logoimage,
      'required_followers_from': requiredfollowerfromController.text,
      'required_followers_to': requiredfollowertoController.text,
      'titles': titleNameController.text,
      'additional_requirements': additionalrequirement.text,
      'status': '1',
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: addguidline
            ? const Text(
                'Add Guildlines for Collaboration',
                style: TextStyle(color: Colors.white),
              )
            : adddeliverable
                ? const Text(
                    'Add Deliverable for Collaboration',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text('New Collaboration Details',
                    style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          addguidline
              ? MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 45,
                  color: purpleColor,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (categories.text.isNotEmpty &&
                        collaborationtype.text.isNotEmpty &&
                        collaborationtypediscription.text.isNotEmpty &&
                        collaborationDescriptionController.text.isNotEmpty &&
                        languageController.text.isNotEmpty &&
                        requiredfollowerfromController.text.isNotEmpty &&
                        requiredfollowertoController.text.isNotEmpty &&
                        titleNameController.text.isNotEmpty &&
                        pickedFile != null &&
                        pickedlogoimage != null &&
                        pickedlogo != null) {
                      // uploadlogoimage();
                      // Navigator.pop(context);
                      setState(() {
                        addguidline = false;
                        adddeliverable = true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          clipBehavior: Clip.antiAlias,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(20),
                          backgroundColor: mainColor,
                          content: const Text(
                            'Please fill all details to upload this course',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              : adddeliverable
                  ? MaterialButton(
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
                        if (categories.text.isNotEmpty &&
                            collaborationtype.text.isNotEmpty &&
                            collaborationtypediscription.text.isNotEmpty &&
                            collaborationDescriptionController
                                .text.isNotEmpty &&
                            languageController.text.isNotEmpty &&
                            requiredfollowerfromController.text.isNotEmpty &&
                            requiredfollowertoController.text.isNotEmpty &&
                            titleNameController.text.isNotEmpty &&
                            pickedFile != null &&
                            pickedlogoimage != null &&
                            pickedlogo != null) {
                          // uploadlogoimage();tertert
                          Navigator.pop(context);
                          setState(() {
                            addguidline = false;
                            adddeliverable = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              clipBehavior: Clip.antiAlias,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(20),
                              backgroundColor: mainColor,
                              content: const Text(
                                'Please fill all details to upload this course',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                      elevation: 5.0,
                      minWidth: 200.0,
                      height: 45,
                      color: purpleColor,
                      child: const Text(
                        'NEXTwweqewrewewewrewr',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (categories.text.isNotEmpty &&
                            collaborationtype.text.isNotEmpty &&
                            collaborationtypediscription.text.isNotEmpty &&
                            collaborationDescriptionController
                                .text.isNotEmpty &&
                            languageController.text.isNotEmpty &&
                            requiredfollowerfromController.text.isNotEmpty &&
                            requiredfollowertoController.text.isNotEmpty &&
                            titleNameController.text.isNotEmpty &&
                            pickedFile != null &&
                            pickedlogoimage != null &&
                            pickedlogo != null) {
                          uploadlogoimage();
                          // Navigator.pop(context);
                          setState(() {
                            addguidline = true;
                            adddeliverable = false;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              clipBehavior: Clip.antiAlias,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(20),
                              backgroundColor: mainColor,
                              content: const Text(
                                'Please fill all details to upload this course',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
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
        addguidline
            ? Container(
                child: Text("guildlines"),
              )
            : adddeliverable
                ? Container(
                    child: Text("delivery"),
                  )
                : Row(
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
                      Column(
                        children: [
                          imageUploadData(),
                          Row(
                            children: [
                              logoimageUploadData(),
                              brandimageUploadData(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
      ],
    );
  }

  mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        imageUploadData(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logoimageUploadData(),
              brandimageUploadData(),
            ],
          ),
        ),
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
            'Upload Collabration Thumbnail here.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  brandimageUploadData() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pickImagebrand();
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
                child: pickedlogo == null
                    ? SizedBox(
                        height: 100,
                        width: 150,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/upload_thumbnail.jpeg',
                              height: 100,
                              width: 150,
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
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.memory(
                          webImagelogo,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Upload Brand Logo here.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  logoimageUploadData() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pickImagelogo();
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
                child: pickedlogoimage == null
                    ? SizedBox(
                        height: 100,
                        width: 150,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/upload_thumbnail.jpeg',
                              height: 100,
                              width: 150,
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
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.memory(
                          webImagelogoimage,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Upload Logo here.',
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
            'Collaboration Title',
            titleNameController,
            'Titles',
          ),
          textfieldWithLabelWidget(
            'Language',
            languageController,
            'Language of the Collaboration',
          ),
          textfieldWithLabelWidget(
            'Collaboration Categories',
            categories,
            'Collaboration Categories',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Required Followers"),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
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
                        controller: requiredfollowerfromController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "From",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
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
                        controller: requiredfollowertoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "To",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          textfieldWithLabelWidget(
            'Additional Requirements',
            additionalrequirement,
            'Additional Requirements',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Collaboration type"),
              const SizedBox(
                height: 10,
              ),
              Container(
                // width: 200,
                padding: const EdgeInsets.symmetric(
                  // vertical: 5,
                  horizontal: 30,
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
                child: DropdownButton<String>(
                  underline: Container(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  value: dropdownValue,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                      collaborationtype.text = value;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Collaboration type discription"),
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
                  maxLines: 10,
                  controller: collaborationtypediscription,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Collaboration type discription",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Description"),
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
                  maxLines: 10,
                  controller: collaborationDescriptionController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description of the Collaboration",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publish Collaboration ?',
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
