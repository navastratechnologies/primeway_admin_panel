// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class CreatorProgramScreen extends StatefulWidget {
  const CreatorProgramScreen({super.key});

  @override
  State<CreatorProgramScreen> createState() => _CreatorProgramScreenState();
}

class _CreatorProgramScreenState extends State<CreatorProgramScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
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
                    child: SizedBox(
                      width: displayWidth(context) / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: displayHeight(context) / 1.25,
                  width: displayWidth(context) / 2,
                  child: StreamBuilder(
                      stream: creator.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
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
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        height: 100,
                                        child: Center(
                                          child: Image.network(
                                            documentSnapshot['image'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['category'],
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: InkWell(
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
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                pickImage();
              },
              child: Container(
                width: displayWidth(context) / 4,
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
                child: pickedFile == null
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
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: displayWidth(context) / 4,
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
              minWidth: displayWidth(context) / 4,
              height: 40,
              color: greenLightShadeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                if (categoryController.text.isNotEmpty && pickedFile != null) {
                  uploadFile();
                } else if (pickedFile == null) {
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
                "Upload",
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
