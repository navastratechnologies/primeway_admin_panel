// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class CreatorProgramScreen extends StatefulWidget {
  const CreatorProgramScreen({super.key});

  @override
  State<CreatorProgramScreen> createState() => _CreatorProgramScreenState();
}

class _CreatorProgramScreenState extends State<CreatorProgramScreen> {
  bool editButton = false;
  String imageUrl = '';
  String baseImage = '';
  String categoryId = '';
  bool showUploader = false;

  File? pickedFile;
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool bannerPicked = false;
  String url = '';

  TextEditingController categoryController = TextEditingController();

  final CollectionReference creator =
      FirebaseFirestore.instance.collection('creator_program_category');

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
          imageUrl = '';
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
        FirebaseStorage.instance.ref().child('creator/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
          () => log('done'),
        )
        .catchError(
          (error) => log('something went wrong : $error'),
        );
    url = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance.collection('creator_program_category').add(
      {
        'image': url.toString(),
        'category': categoryController.text,
      },
    ).whenComplete(
      () {
        setState(
          () {
            editButton = false;
            showUploader = false;
            imageUrl = '';
            baseImage = '';
            categoryId = '';
            pickedFile = null;
          },
        );
      },
    );
  }

  Future<void> deleteCategoryData(categoryId, categoryUrl) async {
    FirebaseFirestore.instance
        .collection('creator_program_category')
        .doc(categoryId)
        .delete();

    FirebaseStorage.instance.refFromURL(categoryUrl).delete().then(
          (value) => log('image deleted from server'),
        );
  }

  Future updateFile(id) async {
    if (pickedFile != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child('creator/${DateTime.now()}.png');
      UploadTask uploadTask = ref.putData(
        webImage,
        SettableMetadata(contentType: 'image/png'),
      );
      TaskSnapshot taskSnapshot = await uploadTask
          .whenComplete(
            () => log('done'),
          )
          .catchError(
            (error) => log('something went wrong : $error'),
          );
      url = await taskSnapshot.ref.getDownloadURL();

      creator.doc(id).update(
        {
          'image': url.toString(),
          'category': categoryController.text,
        },
      );
    } else {
      creator.doc(id).update(
        {
          'image': imageUrl,
          'category': categoryController.text,
        },
      ).whenComplete(
        () {
          setState(
            () {
              editButton = false;
              showUploader = false;
              imageUrl = '';
              baseImage = '';
              categoryId = '';
              pickedFile = null;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) / 1.12,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  displayWidth(context) < 600 || displayWidth(context) < 1200
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
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
                            child: ExpansionTile(
                              backgroundColor: purpleColor,
                              collapsedBackgroundColor: purpleColor,
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(
                                'Add Category',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                uploadSection(context),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: greenLightShadeColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: displayWidth(context) < 600
                                ? Row(
                                    children: [
                                      Text(
                                        'Categories',
                                        style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            "Id",
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
                                          child: Text(
                                            "Image",
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
                                          child: Text(
                                            "Category Name",
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
                                          child: Text(
                                            "Action",
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
                        SizedBox(
                          height: displayWidth(context) < 600
                              ? null
                              : displayHeight(context) / 1.25,
                          child: StreamBuilder(
                              stream: creator.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: displayWidth(context) < 600
                                        ? true
                                        : false,
                                    physics: displayWidth(context) < 600
                                        ? const NeverScrollableScrollPhysics()
                                        : const AlwaysScrollableScrollPhysics(),
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return displayWidth(context) < 600
                                          ? Column(
                                              children: [
                                                ExpansionTile(
                                                  childrenPadding:
                                                      const EdgeInsets.all(6),
                                                  tilePadding:
                                                      const EdgeInsets.all(6),
                                                  title: SelectableText(
                                                    documentSnapshot.id,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    expansionTableData(
                                                      'Category Name',
                                                      documentSnapshot[
                                                          'category'],
                                                      context,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            child:
                                                                SelectableText(
                                                              'Category Image',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 200,
                                                            height: 100,
                                                            child: Center(
                                                              child:
                                                                  Image.network(
                                                                documentSnapshot[
                                                                    'image'],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: buttons(
                                                          documentSnapshot),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2),
                                                const Divider(),
                                              ],
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Center(
                                                          child: Text(
                                                            documentSnapshot.id,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        height: 100,
                                                        child: Center(
                                                          child: Image.network(
                                                            documentSnapshot[
                                                                'image'],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Center(
                                                          child: Text(
                                                            documentSnapshot[
                                                                'category'],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      buttons(documentSnapshot),
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
                  ),
                ],
              ),
            ),
            displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Container()
                : const SizedBox(width: 10),
            displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Container()
                : uploadSection(context)
          ],
        ),
      ),
    );
  }

  buttons(DocumentSnapshot<Object?> documentSnapshot) {
    return SizedBox(
      width: 120,
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                deleteCategoryData(
                  documentSnapshot.id,
                  documentSnapshot['image'],
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: mainShadeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FaIcon(
                  FontAwesomeIcons.trashCan,
                  color: whiteColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                setState(() {
                  editButton = true;
                  imageUrl = documentSnapshot['image'];
                  baseImage = documentSnapshot['image'];
                  categoryId = documentSnapshot.id;
                  categoryController.text = documentSnapshot['category'];
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: greenShadeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FaIcon(
                  FontAwesomeIcons.pen,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MaterialButton(
            color: mainShadeColor,
            onPressed: () {
              setState(
                () {
                  editButton = false;
                  showUploader = false;
                  imageUrl = '';
                  baseImage = '';
                  categoryId = '';
                  pickedFile = null;
                  categoryController.clear();
                },
              );
            },
            child: Text(
              'Clear',
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              pickImage();
            },
            child: Container(
              width: displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? displayWidth(context)
                  : displayWidth(context) / 4,
              height: 200,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  imageUrl.isNotEmpty
                      ? Image.network(imageUrl)
                      : pickedFile == null
                          ? Center(
                              child: FaIcon(
                                FontAwesomeIcons.camera,
                                size: 100,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            )
                          : kIsWeb
                              ? Image.memory(webImage)
                              : Image.file(pickedFile!),
                  showUploader
                      ? Center(
                          child: CircularProgressIndicator(
                            color: greenShadeColor,
                            strokeWidth: 5,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? displayWidth(context)
                : displayWidth(context) / 4,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TextFormField(
              controller: categoryController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Creator Program Category name',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            minWidth:
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? displayWidth(context)
                    : displayWidth(context) / 4,
            height: 40,
            color: editButton ? purpleColor : greenLightShadeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: editButton
                ? () => updateFile(categoryId)
                : () {
                    if (categoryController.text.isNotEmpty &&
                        pickedFile != null) {
                      uploadFile();
                    } else if (pickedFile == null && imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please select image to upload',
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            left: displayWidth(context) / 1.3,
                            right: 50,
                            bottom: 100,
                          ),
                          backgroundColor: mainColor,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please enter category name to upload',
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            left: displayWidth(context) / 1.3,
                            right: 50,
                            bottom: 100,
                          ),
                          backgroundColor: mainColor,
                        ),
                      );
                    }
                  },
            child: Text(
              editButton ? "Update" : "Upload",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
