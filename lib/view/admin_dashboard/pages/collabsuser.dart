// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primeway_admin_panel/controller/send_notification_controller.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

const List<String> list = <String>['paid', 'Barter'];

class CollabUserScreen extends StatefulWidget {
  final String docId;
  const CollabUserScreen({
    super.key,
    required this.docId,
  });

  @override
  State<CollabUserScreen> createState() => _CollabUserScreenState();
}

class _CollabUserScreenState extends State<CollabUserScreen> {
  final CollectionReference collaboration =
      FirebaseFirestore.instance.collection('collaboration');
  Future<AggregateQuerySnapshot> count =
      FirebaseFirestore.instance.collection('collaboration').count().get();

  String dropdownValue = list.first;
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
  TextEditingController payoutController = TextEditingController();
  String requirment_type = 'requirment_type';
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
      'status': draft,
      'requirement_type': requirment_type,
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
        categories.text = value.get("categories");
        collaborationtype.text = value.get("collaboration_type");
        collaborationtypediscription.text =
            value.get("collaboration_type_discription");
        collaborationDescriptionController.text = value.get("descreption");
        logoController.text = value.get("logo");
        requiredfollowerfromController.text =
            value.get("required_followers_from");
        requiredfollowertoController.text = value.get("required_followers_to");
        languageController.text = value.get("language");
        titleNameController.text = value.get("titles");
        additionalrequirement.text = value.get("additional_requirements");
        draft = value.get("status");
        requirment_type = value.get("requirement_type");
      });
    });
    log("jakHSKJhs $draft");
  }

  @override
  void initState() {
    getuploadedFilefirebase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: greenShadeColor,
        title: const Text(
          'Collaboration User Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
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
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dataofuser(),
                const SizedBox(
                  width: 40,
                ),
                datacount(),
              ],
            )),
          ]),
        ),
      ],
    );
  }

  mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: VerticalDivider(
            thickness: 1.2,
            indent: 20,
            endIndent: 20,
            color: Colors.black.withOpacity(0.05),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              datacount(),
              const SizedBox(height: 20),
              dataofuser(),
            ],
          ),
        ),
      ],
    );
  }

  dataofuser() {
    return Expanded(
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: displayWidth(context) / 1.4,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: greenShadeColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        "Id",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "Image",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "User Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "Task Uploaded",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "Task verified",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "View_brief",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      child: Text(
                        "Date And Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: displayHeight(context) / 2.75,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: StreamBuilder(
                    stream: collaboration
                        .doc(widget.docId)
                        .collection('users')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            log("lenght isfdsfsd $streamSnapshot.data!.docs.length");
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: InkWell(
                                onTap: () {
                                  internalCollabUserDetails(
                                    context,
                                    documentSnapshot['number'],
                                    documentSnapshot['name'],
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "${index.toString()}. ",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 80,
                                      child: Center(
                                        child: Image.network(
                                          documentSnapshot['profile_pic'],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['name'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['number'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['task_uploaded'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['task_verified'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['view_brief'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        documentSnapshot['date_time'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  internalCollabUserDetails(context, userNumber, userName) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(10),
              content: SizedBox(
                width: displayWidth(context) / 2,
                height: displayHeight(context),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: greenLightShadeColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Tasks',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('collaboration')
                                              .doc(widget.docId)
                                              .collection('deliverables')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteColor,
                                                  fontSize: 70,
                                                ),
                                              );
                                            }
                                            return Text(
                                              '0',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: whiteColor,
                                                fontSize: 70,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: greenLightShadeColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tasks Completed',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('collaboration')
                                              .doc(widget.docId)
                                              .collection('users')
                                              .doc(userNumber)
                                              .collection('tasks')
                                              .where('status',
                                                  isEqualTo: 'uploaded')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteColor,
                                                  fontSize: 70,
                                                ),
                                              );
                                            }
                                            return Text(
                                              '0',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: whiteColor,
                                                fontSize: 70,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 600,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('collaboration')
                                    .doc(widget.docId)
                                    .collection('users')
                                    .doc(userNumber)
                                    .collection('tasks')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot taskSnapshot =
                                            snapshot.data!.docs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ExpansionTile(
                                            title: Text(
                                              taskSnapshot['title'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      width: 200,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: mainColor
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 10,
                                                            spreadRadius: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      child:
                                                          taskSnapshot['task']
                                                                  .toString()
                                                                  .isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                    'Task Not Uploaded yet',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Image.network(
                                                                  taskSnapshot[
                                                                      'task'],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'collaboration')
                                                            .doc(widget.docId)
                                                            .collection('users')
                                                            .doc(userNumber)
                                                            .collection('tasks')
                                                            .doc(
                                                                taskSnapshot.id)
                                                            .update(
                                                          {
                                                            'status':
                                                                'verified',
                                                          },
                                                        );
                                                      },
                                                      color:
                                                          greenLightShadeColor,
                                                      child: Text(
                                                        'Approve Task',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: whiteColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'collaboration')
                                                            .doc(widget.docId)
                                                            .collection('users')
                                                            .doc(userNumber)
                                                            .collection('tasks')
                                                            .doc(
                                                                taskSnapshot.id)
                                                            .update(
                                                          {
                                                            'status':
                                                                'rejected',
                                                            'task': '',
                                                          },
                                                        );
                                                      },
                                                      color: mainColor,
                                                      child: Text(
                                                        'Reject Task',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: whiteColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('collaboration')
                                    .doc(widget.docId)
                                    .get()
                                    .then(
                                  (value) {
                                    log('payment is ${value.get('payout')}');
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userNumber)
                                        .get()
                                        .then(
                                      (value1) {
                                        FirebaseFirestore.instance
                                            .collection('notifications')
                                            .add(
                                          {
                                            'date_time': '',
                                            'message':
                                                'Congrats! You have successfully completed all the tasks of the collaboration that you applied and received Rs.${value.get('payout')} in your wallet',
                                            'number': userNumber.toString(),
                                            'name': userName.toString(),
                                            'pic': value1.get('profile_pic'),
                                          },
                                        );
                                        FirebaseFirestore.instance
                                            .collection('wallet')
                                            .doc(userNumber)
                                            .get()
                                            .then(
                                          (value3) {
                                            var wBal = double.parse(value3
                                                .get('wallet_balance')
                                                .toString());
                                            var totalWBal = wBal +
                                                double.parse(
                                                  value.get('payout'),
                                                );
                                            log('wal bal is $wBal $totalWBal');
                                            FirebaseFirestore.instance
                                                .collection('wallet')
                                                .doc(userNumber)
                                                .update(
                                              {
                                                'wallet_balance':
                                                    totalWBal.toString(),
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );

                                    FirebaseFirestore.instance
                                        .collection('user_token')
                                        .doc(userNumber)
                                        .get()
                                        .then(
                                      (value2) {
                                        sendPushMessage(
                                          value2.get('token'),
                                          'You have successfully completed all the tasks of the collaboration that you applied and received Rs.${value.get('payout')} in your wallet',
                                          'Congrats!',
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              color: greenLightShadeColor,
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Approve and Send Payment',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Container(
                                            width: displayWidth(context) / 3,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: greenLightShadeColor,
                                            ),
                                            child: Text(
                                              'Send Custom Payment',
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 40,
                                          ),
                                          content: TextFormField(
                                            controller: payoutController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            decoration: const InputDecoration(
                                              hintText:
                                                  'Enter Custom Payout Here',
                                            ),
                                          ),
                                          actions: [
                                            MaterialButton(
                                              color: mainColor,
                                              onPressed: () => setState(
                                                () => payoutController.clear(),
                                              ),
                                              child: Text(
                                                'Clear',
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            MaterialButton(
                                              color: purpleColor,
                                              onPressed: () {
                                                double payoutControllerText =
                                                    double.parse(
                                                        payoutController.text);
                                                log('payment is $payoutControllerText');
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userNumber)
                                                    .get()
                                                    .then(
                                                  (value1) {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'notifications')
                                                        .add(
                                                      {
                                                        'date_time': '',
                                                        'message':
                                                            'Congrats! You have successfully completed all the tasks of the collaboration that you applied and received Rs.${payoutController.text} in your wallet',
                                                        'number': userNumber
                                                            .toString(),
                                                        'name':
                                                            userName.toString(),
                                                        'pic': value1
                                                            .get('profile_pic'),
                                                      },
                                                    );
                                                    log('user number is $userNumber');
                                                    FirebaseFirestore.instance
                                                        .collection('wallet')
                                                        .doc(userNumber)
                                                        .get()
                                                        .then(
                                                      (value3) {
                                                        var wBal = double.parse(
                                                            value3
                                                                .get(
                                                                    'wallet_balance')
                                                                .toString());
                                                        var totalWBal = wBal +
                                                            payoutControllerText;
                                                        log('wal bal is $wBal $payoutControllerText');
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'wallet')
                                                            .doc(userNumber)
                                                            .update(
                                                          {
                                                            'wallet_balance':
                                                                totalWBal
                                                                    .toString(),
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                );

                                                FirebaseFirestore.instance
                                                    .collection('user_token')
                                                    .doc(userNumber)
                                                    .get()
                                                    .then(
                                                  (value2) {
                                                    sendPushMessage(
                                                      value2.get('token'),
                                                      'You have successfully completed all the tasks of the collaboration that you applied and received Rs.$payoutControllerText in your wallet',
                                                      'Congrats!',
                                                    );
                                                  },
                                                );
                                                setState(
                                                  () =>
                                                      payoutController.clear(),
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Send Payout',
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              color: purpleColor,
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Approve and Send Custom Payment',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: MaterialButton(
                          color: purpleColor,
                          shape: const CircleBorder(),
                          minWidth: 0,
                          onPressed: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close_rounded,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  datacount() {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: displayWidth(context) / 1.4,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: greenShadeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          "Task Status",
                          style: TextStyle(
                            color: Colors.white,
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
              width: 400,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Total Task',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("collaboration")
                                  .doc(widget.docId)
                                  .collection("deliverables")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${streamSnapshot.data!.docs.length}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Total Participated User',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("collaboration")
                                  .doc(widget.docId)
                                  .collection("users")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${streamSnapshot.data!.docs.length}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Task completed',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("collaboration")
                                  .doc(widget.docId)
                                  .collection("users")
                                  .where('task_uploaded', isEqualTo: 'true')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${streamSnapshot.data!.docs.length}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Task Incomplete',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("collaboration")
                                  .doc(widget.docId)
                                  .collection("users")
                                  .where('task_uploaded', isEqualTo: 'false')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${streamSnapshot.data!.docs.length}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Task Varified',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("collaboration")
                                  .doc(widget.docId)
                                  .collection("users")
                                  .where('task_verified', isEqualTo: 'true')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${streamSnapshot.data!.docs.length}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          'Task unverified',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("collaboration")
                                .doc(widget.docId)
                                .collection("users")
                                .where('task_verified', isEqualTo: 'false')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${streamSnapshot.data!.docs.length}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox(
                                width: 150,
                                height: 50,
                                child: Text(
                                  ' 0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    color: purpleColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('collaboration')
                          .doc(widget.docId)
                          .collection('users')
                          .get()
                          .then(
                        (value) {
                          if (value.docs.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('collaboration')
                                .doc(widget.docId)
                                .collection('users')
                                .where('task_uploaded', isNotEqualTo: 'true')
                                .get()
                                .then(
                              (value) {
                                log('total task users ${value.docs.length} ${value.docs[1]['name']}');
                                for (var i = 0; i < value.docs.length; i++) {
                                  FirebaseFirestore.instance
                                      .collection('user_token')
                                      .doc(value.docs[i]['number'])
                                      .get()
                                      .then(
                                    (value1) {
                                      sendPushMessage(
                                        value1.get('token'),
                                        'Complete your tasks to get the payout',
                                        'Payout is waiting for you',
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          } else {
                            log('no one applied for collaboration');
                          }
                        },
                      );
                    },
                    child: Text(
                      'Send Notification to Users to Complete tasks',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            enabled: false,
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
