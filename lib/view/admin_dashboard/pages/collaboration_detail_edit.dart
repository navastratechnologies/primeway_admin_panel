// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as htmlwidget;
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

const List<String> list = <String>['paid', 'Barter'];
List<String> languagelist = <String>['English', 'Hindi', 'Punjabi'];
List<String> items = [];
List selectedItems = [];
List selectedItem = [];

class CollaborationeditScreen extends StatefulWidget {
  final String docId;
  const CollaborationeditScreen({
    super.key,
    required this.docId,
  });

  @override
  State<CollaborationeditScreen> createState() =>
      _CollaborationeditScreenState();
}

class _CollaborationeditScreenState extends State<CollaborationeditScreen> {
  final CollectionReference collaboration =
      FirebaseFirestore.instance.collection('collaboration');

  ///[controller] create a QuillEditorController to access the editor methods
  QuillEditorController controller = QuillEditorController();
  String dropdownValue = list.first;
  QuillEditorController controllertext = QuillEditorController();
  TextEditingController titleNameController = TextEditingController();
  TextEditingController requiredfollowerfromController =
      TextEditingController();
  TextEditingController requiredfollowertoController = TextEditingController();
  TextEditingController collaborationDescriptionController =
      TextEditingController();
  TextEditingController collaborationtypediscription = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController brandlogoController = TextEditingController();
  TextEditingController logoController = TextEditingController();
  TextEditingController additionalrequirement = TextEditingController();
  TextEditingController collaborationtype = TextEditingController(text: "paid");
  TextEditingController categories = TextEditingController();
  TextEditingController duration = TextEditingController();

  // ignore: non_constant_identifier_names
  String requirment_type = 'requirment_type';
  String instructionText = '';
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

    FirebaseFirestore.instance
        .collection('collaboration')
        .doc(widget.docId)
        .update({
      'image': pickedFile != null ? url.toString() : imageController.text,
      'brand_logo': pickedlogo != null ? logo : brandlogoController.text,
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
      'status': draft,
      'requirement_type': requirment_type,
      'instructions': instructionText,
      'duration': duration.text,
    });
  }

  Future<void> getuploadedFilefirebase() async {
    FirebaseFirestore.instance
        .collection('collaboration')
        .doc(widget.docId)
        .get()
        .then((value) {
      setState(() {
        imageController.text = value.get("image");
        brandlogoController.text = value.get("brand_logo");
        selectedItems =
            value.get("categories").toString().replaceAll(' ', '').split(",");
        collaborationtype.text = value.get("collaboration_type");
        collaborationtypediscription.text =
            value.get("collaboration_type_discription");
        collaborationDescriptionController.text = value.get("descreption");
        logoController.text = value.get("logo");
        requiredfollowerfromController.text =
            value.get("required_followers_from");
        requiredfollowertoController.text = value.get("required_followers_to");
        selectedItem =
            value.get("language").toString().replaceAll(' ', '').split(",");
        titleNameController.text = value.get("titles");
        additionalrequirement.text = value.get("additional_requirements");
        requirment_type = value.get("requirement_type");
        instructionText = value.get("instructions");
        duration.text = value.get("duration");
        draft = value.get("status");
        controller.setText(
          value.get('instructions'),
        );
        setHtmlText(value.get('instructions'));
      });
    });

    log("jakHSKJhs $instructionText");
  }

  Future getCatagory() async {
    setState(() {
      items.clear();
    });

    try {
      final productsRef =
          FirebaseFirestore.instance.collection('creator_program_category');
      final snapshot = await productsRef.get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          for (var doc in snapshot.docs) {
            items.add(doc.data()['category']);
          }
        });
        log("Message: $items ");
      } else {
        log("Error: Collection is empty");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  @override
  void initState() {
    getCatagory();
    getuploadedFilefirebase();
    controller.onTextChanged((text) {
      setState(() {
        instructionText = text;
      });
      debugPrint('listening to $instructionText');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: const Text(
          'Edit Collaboration Details',
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
              if (collaborationtype.text.isNotEmpty &&
                  collaborationtypediscription.text.isNotEmpty &&
                  collaborationDescriptionController.text.isNotEmpty &&
                  requiredfollowerfromController.text.isNotEmpty &&
                  requiredfollowertoController.text.isNotEmpty &&
                  titleNameController.text.isNotEmpty) {
                uploadlogoimage();
                Navigator.pop(context);
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
    return Row(
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
    );
  }

  mobileBody() {
    return Column(
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
                            Image.network(
                              imageController.text,
                              height: 200,
                              width: 300,
                              fit: BoxFit.cover,
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
                            Image.network(
                              brandlogoController.text,
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
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
                            Image.network(
                              logoController.text,
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Additional Detail',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    color: purpleColor,
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        'View Guidelines',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      addUnit(context);
                    },
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'view Deliverable',
                        style: TextStyle(
                          color: Colors.white,
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

  addUnit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Edit Guidelines',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: instructionText,
                                    ),
                                  );

                                  // .then(
                                  //   (_) {
                                  //     alertDialogWidget(
                                  //       context,
                                  //       primeColor2,
                                  //       "Referral code copied to clipboard",
                                  //     );
                                  //   },
                                  // );
                                },
                                child: const Icon(Icons.copy_all)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: instructionText,
                                ),
                              );
                            },
                            child: SizedBox(
                              height: displayHeight(context) / 1.5,
                              width: displayWidth(context) / 1.5,
                              child: Container(
                                color: Colors.black45,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: htmlwidget.HtmlWidget(
                                    instructionText,
                                    buildAsync: true,
                                    enableCaching: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5.0,
                          minWidth: 80.0,
                          height: 45,
                          color: Colors.green,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            // uploaddeliveryFile();
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5.0,
                          minWidth: 80.0,
                          height: 45,
                          color: Colors.blue,
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText.toString());
  }

  /// to set the html text to editor
  void setHtmlText(String instructionText) async {
    await controller.setText(instructionText);

    log('dadghashgd ${controller.getText().then((value) => value)} $instructionText');
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(true);
}
