// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  bool editButton = false;
  String imageUrl = '';
  String baseImage = '';
  String bannerId = '';
  bool showUploader = false;

  File? pickedFile;
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool bannerPicked = false;

  final CollectionReference banner =
      FirebaseFirestore.instance.collection('Banner');

  Future<void> pickImage() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          imageUrl = '';
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
        FirebaseStorage.instance.ref().child('Banner/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
          () => print('done'),
        )
        .catchError(
          (error) => print('something went wrong'),
        );
    String url = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance.collection('Banner').add({
      'Banner_image': url.toString(),
      'Banner_link': 'google.com',
      'Banner_name': 'Banner',
    }).whenComplete(
      () {
        setState(() {
          editButton = false;
          showUploader = false;
          imageUrl = '';
          baseImage = '';
          bannerId = '';
          pickedFile = null;
        });
      },
    );
  }

  Future<void> deleteBannerData(bannerId, bannerImage) async {
    FirebaseFirestore.instance.collection('Banner').doc(bannerId).delete();

    FirebaseStorage.instance.refFromURL(bannerImage).delete().then(
          (value) => log('image deleted from server'),
        );
  }

  Future updateFile(id) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('Banner/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
          () => print('done'),
        )
        .catchError(
          (error) => print('something went wrong'),
        );
    String url = await taskSnapshot.ref.getDownloadURL();

    banner.doc(id).update({
      'Banner_image': url.toString(),
      'Banner_link': 'google.com',
      'Banner_name': 'Banner',
    }).whenComplete(
      () {
        setState(() {
          editButton = false;
          showUploader = false;
          imageUrl = '';
          baseImage = '';
          bannerId = '';
          pickedFile = null;
        });
      },
    );
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Upload Banner',
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      "Banner Id",
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
                                      "Banner Image",
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                displayWidth(context) < 600
                                    ? const SizedBox()
                                    : SizedBox(
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: displayWidth(context) < 600 ||
                                  displayWidth(context) < 1200
                              ? null
                              : displayHeight(context) / 1.25,
                          child: StreamBuilder(
                              stream: banner.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: displayWidth(context) < 600 ||
                                            displayWidth(context) < 1200
                                        ? true
                                        : false,
                                    physics: displayWidth(context) < 600 ||
                                            displayWidth(context) < 1200
                                        ? const NeverScrollableScrollPhysics()
                                        : const AlwaysScrollableScrollPhysics(),
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: Text(
                                                    documentSnapshot.id,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 120,
                                                    height: 100,
                                                    child: Center(
                                                      child: Image.network(
                                                        documentSnapshot[
                                                            'Banner_image'],
                                                      ),
                                                    ),
                                                  ),
                                                  displayWidth(context) < 600
                                                      ? buttons(
                                                          documentSnapshot)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                              displayWidth(context) < 600
                                                  ? const SizedBox()
                                                  : buttons(documentSnapshot),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          const Divider(),
                                        ],
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
                : uploadSection(context),
          ],
        ),
      ),
    );
  }

  uploadSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: displayWidth(context) < 600 || displayWidth(context) < 1200
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      padding: const EdgeInsets.all(20),
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
                  bannerId = '';
                  pickedFile = null;
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
            onTap: pickImage,
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
          MaterialButton(
            minWidth:
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? displayWidth(context)
                    : displayWidth(context) / 4,
            height: 40,
            color: editButton ? purpleColor : greenShadeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: editButton
                ? () {
                    setState(() {
                      showUploader = true;
                    });
                    updateFile(bannerId);
                  }
                : () {
                    if (pickedFile != null) {
                      setState(() {
                        showUploader = true;
                      });
                      uploadFile();
                    } else {
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
                    }
                  },
            child: Text(
              editButton ? "Update Image" : "Upload Image",
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

  buttons(DocumentSnapshot<Object?> documentSnapshot) {
    return SizedBox(
      width: 120,
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                deleteBannerData(
                  documentSnapshot.id,
                  documentSnapshot['Banner_image'],
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
                  imageUrl = documentSnapshot['Banner_image'];
                  baseImage = documentSnapshot['Banner_image'];
                  bannerId = documentSnapshot.id;
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
}
