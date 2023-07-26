// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../course_dashboard/pages/quil.dart';
import 'loader.dart';

const List<String> list = <String>['paid', 'Barter'];
const List<String> languagelist = <String>['English', 'Hindi', 'Punjabi'];
List<String> items = [];
List selectedItems = [];
List selectedItem = [];

class CollaborationDetailsScreen extends StatefulWidget {
  const CollaborationDetailsScreen({
    super.key,
  });

  @override
  State<CollaborationDetailsScreen> createState() =>
      _CollaborationDetailsScreenState();
}

class _CollaborationDetailsScreenState
    extends State<CollaborationDetailsScreen> {
  ///[controller] create a QuillEditorController to access the editor methods
  final QuillEditorController controller = QuillEditorController();
  bool loader = false;

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
  ];
  bool addguidline = false;

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
  TextEditingController duration = TextEditingController();
  TextEditingController collaborationPayoutController =
      TextEditingController(text: '0');
  String instructionText = '';
  String instruction = 'text';

  String logoimage = "";
  String logo = "";
  String dmimage = "";
  String draft = 'Draft';
  // ignore: non_constant_identifier_names
  String requirment_type = 'requirment_type';
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
      'categories':
          selectedItems.toString().replaceAll("[", '').replaceAll("]", ''),
      'collaboration_type': collaborationtype.text,
      'collaboration_type_discription': collaborationtypediscription.text,
      'descreption': collaborationDescriptionController.text,
      'language':
          languagelist.toString().replaceAll("[", '').replaceAll("]", ''),
      'logo': logoimage,
      'required_followers_from': requiredfollowerfromController.text,
      'required_followers_to': requiredfollowertoController.text,
      'titles': titleNameController.text,
      'additional_requirements': additionalrequirement.text,
      'status': draft,
      'requirement_type': requirment_type,
      'instructions': instructionText,
      'duration': duration.text,
      'payout': collaborationPayoutController.text,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Quilscreen(
              docId: value.id,
            );
          },
        ),
      );

      log("saSAsa  ${value.id}");
    });
  }

  Future getcatagory() async {
    setState(() {
      items.clear();
    });

    final productsRef =
        FirebaseFirestore.instance.collection('creator_program_category');
    final snapshot = await productsRef.get();
    setState(() {
      for (var doc in snapshot.docs) {
        items.add(doc.data()['category']);
      }

      log(" messdadassaage $items ");
    });
  }

  @override
  void initState() {
    getcatagory();
    controller.onTextChanged((text) {
      setState(() {
        instructionText = text;
      });
      debugPrint('listening to $instructionText');
    });

    controller.onTextChanged((text) {
      setState(() {
        text = instruction;
      });
      debugPrint('listening to $instructionText');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: greenShadeColor,
            title: addguidline
                ? const Text(
                    'Add Guildlines for Collaboration',
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
                        if (collaborationtype.text.isNotEmpty &&
                            collaborationtypediscription.text.isNotEmpty &&
                            collaborationDescriptionController
                                .text.isNotEmpty &&
                            requiredfollowerfromController.text.isNotEmpty &&
                            requiredfollowertoController.text.isNotEmpty &&
                            titleNameController.text.isNotEmpty &&
                            pickedFile != null &&
                            pickedlogoimage != null &&
                            pickedlogo != null) {
                          uploadlogoimage();
                          // Navigator.pop(context);
                          setState(() {
                            addguidline = false;
                            loader = true;
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
                        'NEXT to delivery',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (selectedItems.toString().isNotEmpty &&
                            languagelist.toString().isNotEmpty &&
                            collaborationtype.text.isNotEmpty &&
                            collaborationtypediscription.text.isNotEmpty &&
                            collaborationDescriptionController
                                .text.isNotEmpty &&
                            requiredfollowerfromController.text.isNotEmpty &&
                            requiredfollowertoController.text.isNotEmpty &&
                            titleNameController.text.isNotEmpty &&
                            pickedFile != null &&
                            pickedlogoimage != null &&
                            pickedlogo != null) {
                          // uploadlogoimage();
                          // Navigator.pop(context);
                          setState(() {
                            addguidline = true;
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
        ),
        loader ? const LoaderWidget() : Container(),
      ],
    );
  }

  desktopBody() {
    return Stack(
      children: [
        addguidline
            // ignore: avoid_unnecessary_containers
            ? textguid()
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
    // String selectedvalue = items.first;
    var selectedlanguagevalue = languagelist.first;
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Language"),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: DropdownButton<String>(
                      value: selectedlanguagevalue,
                      // isExpanded: true,
                      items: languagelist.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: <Widget>[
                              selectedItem.contains(item)
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.check_box_outline_blank),
                              const SizedBox(width: 10),
                              Text(item),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (selectedItem.contains(value)) {
                            selectedItem.remove(value);
                          } else {
                            selectedItem.add(value);
                          }
                        });
                      },
                    ),
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
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "$selectedItem".replaceAll("[", '').replaceAll("]", ''),
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Collaboration Categories"),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.arrow_circle_down_outlined,
                          size: 30,
                        ),
                      ),
                      value: null,
                      // isExpanded: true,
                      items: items.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: <Widget>[
                              selectedItems.contains(item)
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.check_box_outline_blank),
                              const SizedBox(width: 10),
                              Text(item),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (selectedItems.contains(value)) {
                            selectedItems.remove(value);
                          } else {
                            selectedItems.add(value);
                          }
                        });
                      },
                    ),
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
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "$selectedItems"
                            .replaceAll("[", '')
                            .replaceAll("]", ''),
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
              const SizedBox(height: 10),
              collaborationtype.text == 'paid'
                  ? Container(
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
                      child: TextFormField(
                        controller: collaborationPayoutController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Payout Amount Here',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Container(),
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
                    value: '3',
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
                    value: '1',
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Requirment type',
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
                    value: 'youtube',
                    groupValue: requirment_type,
                    onChanged: (value) {
                      setState(() {
                        requirment_type = value.toString();
                      });
                    },
                  ),
                  Text(
                    'youtube',
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
                    value: 'insta',
                    groupValue: requirment_type,
                    onChanged: (value) {
                      setState(() {
                        requirment_type = value.toString();
                      });
                    },
                  ),
                  Text(
                    'Instagram',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Duration"),
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
                  controller: duration,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "In Days",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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

  textguid() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250), // Set this height
          child: SafeArea(
            child: ToolBar(
              toolBarColor: Colors.cyan.shade50,
              padding: const EdgeInsets.all(8),
              iconSize: 20,
              activeIconColor: Colors.green,
              controller: controller,
              customButtons: [
                InkWell(
                    onTap: () async {},
                    child: const Icon(
                      Icons.favorite,
                    )),
                InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add_circle,
                    )),
              ],
            ),
          )),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.black45,
                child: QuillHtmlEditor(
                  hintText: 'Hint text goes here',
                  controller: controller,
                  minHeight: MediaQuery.of(context).size.height,
                  onTextChanged: (text) =>
                      debugPrint('widget text change $text'),
                  isEnabled: true,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText.toString());
  }

  /// to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);
}
