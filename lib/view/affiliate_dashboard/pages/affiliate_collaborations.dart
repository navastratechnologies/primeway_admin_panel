import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AffiliateCollaborations extends StatefulWidget {
  const AffiliateCollaborations({super.key});

  @override
  State<AffiliateCollaborations> createState() =>
      _AffiliateCollaborationsState();
}

class _AffiliateCollaborationsState extends State<AffiliateCollaborations> {
  var data = {};
  String userCount = '';
  String coursesCount = '';
  String collaborationCount = '';

  String searchId = '';
  // ignore: non_constant_identifier_names
  bool TotalShared = true;

  TextEditingController searchController = TextEditingController();

  final CollectionReference collabs =
      FirebaseFirestore.instance.collection('collaboration');

  bool showAffiliatePCollabParticipatedPanel = false;
  bool showAffiliatePCollabcompletedPanel = false;
  String docId = '';

  @override
  Widget build(BuildContext context) {
    return showAffiliatePCollabParticipatedPanel
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        mainBody(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: mainBody(),
                      ),
                    ],
                  ),
          )
        : Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: StreamBuilder(
                  stream: collabs.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ResponsiveGridList(
                        horizontalGridSpacing: 10,
                        minItemWidth: displayWidth(context) < 600
                            ? displayWidth(context)
                            : displayWidth(context) < 1200
                                ? displayWidth(context) / 3
                                : displayWidth(context) / 4,
                        listViewBuilderOptions: ListViewBuilderOptions(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        children: List.generate(
                          snapshot.data!.docs.length,
                          (index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Builder(builder: (context) {
                                        return AlertDialog(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'View List Options',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.4,
                                                  ),
                                                ),
                                              ),
                                              MaterialButton(
                                                shape: const CircleBorder(),
                                                color: mainColor,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                  docId = documentSnapshot.id
                                                      .toString();
                                                  showAffiliatePCollabParticipatedPanel =
                                                      false;
                                                  showAffiliatePCollabcompletedPanel =
                                                      true;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: greenShadeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  'View total users who completed task',
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                  docId = documentSnapshot.id
                                                      .toString();
                                                  showAffiliatePCollabParticipatedPanel =
                                                      true;
                                                  showAffiliatePCollabcompletedPanel =
                                                      false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: purpleColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  'View total users who participated in this collab',
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: ImageNetwork(
                                                image:
                                                    documentSnapshot['image'],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                imageCache:
                                                    CachedNetworkImageProvider(
                                                  documentSnapshot['image'],
                                                ),
                                                height: 100,
                                                width: 100,
                                                fitWeb: BoxFitWeb.contain,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                documentSnapshot['titles'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      StreamBuilder(
                                                        stream: collabs
                                                            .doc(
                                                                documentSnapshot
                                                                    .id)
                                                            .collection('users')
                                                            .where(
                                                                'task_uploaded',
                                                                isEqualTo:
                                                                    'true')
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot.data!
                                                                  .docs.length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 26,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            );
                                                          }
                                                          return Text(
                                                            "00",
                                                            style: TextStyle(
                                                              fontSize: 26,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              greenShadeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          'Total Users Completed task',
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      StreamBuilder(
                                                        stream: collabs
                                                            .doc(
                                                                documentSnapshot
                                                                    .id)
                                                            .collection('users')
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot.data!
                                                                  .docs.length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 26,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            );
                                                          }
                                                          return Text(
                                                            "00",
                                                            style: TextStyle(
                                                              fontSize: 26,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: purpleColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          'Total Users Participated',
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          );
  }

  mainBody() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayWidth(context) < 600 || displayWidth(context) < 1200
              ? const SizedBox()
              : StreamBuilder(
                  stream: collabs.where('id', isEqualTo: docId).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
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
                                MaterialButton(
                                  color: purpleColor,
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      docId = '';
                                      showAffiliatePCollabParticipatedPanel =
                                          false;
                                      showAffiliatePCollabcompletedPanel =
                                          false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_rounded,
                                        color: whiteColor,
                                      ),
                                      Text(
                                        'Go Back',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ImageNetwork(
                                              image: documentSnapshot['image'],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              imageCache:
                                                  CachedNetworkImageProvider(
                                                documentSnapshot['image'],
                                              ),
                                              height: 100,
                                              width: 100,
                                              fitWeb: BoxFitWeb.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              documentSnapshot['titles'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    StreamBuilder(
                                                      stream: collabs
                                                          .doc(documentSnapshot
                                                              .id)
                                                          .collection('users')
                                                          .where(
                                                              'task_uploaded',
                                                              isEqualTo: 'true')
                                                          .snapshots(),
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            snapshot.data!.docs
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 26,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        }
                                                        return Text(
                                                          "00",
                                                          style: TextStyle(
                                                            fontSize: 26,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        color: greenShadeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        'Total Users Completed task',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    StreamBuilder(
                                                      stream: collabs
                                                          .doc(documentSnapshot
                                                              .id)
                                                          .collection('users')
                                                          .snapshots(),
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            snapshot.data!.docs
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 26,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        }
                                                        return Text(
                                                          "00",
                                                          style: TextStyle(
                                                            fontSize: 26,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        color: purpleColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        'Total Users Participated',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 30),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      'Export Data In Excel Format',
                                                      style: TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
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
          const SizedBox(height: 10),
          adminTabel(context),
        ],
      ),
    );
  }

  adminTabel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: elevationColor,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: purpleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Withdrawal Requests :-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
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
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchId = searchController.text;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              searchId = searchController.text;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter transaction id to search',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Center(
                          child: Text(
                            "User Id",
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
                            "UserName",
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
                            "Purchased at",
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
                            "Course Value",
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
          Container(
            padding: const EdgeInsets.all(10),
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.45,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('courses')
                    .doc(docId)
                    .collection('purchased_users')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: displayWidth(context) < 600 ||
                                  displayWidth(context) < 1200
                              ? Column(
                                  children: [
                                    ExpansionTile(
                                      childrenPadding: const EdgeInsets.all(10),
                                      tilePadding: const EdgeInsets.all(6),
                                      title: Text(
                                        documentSnapshot['user_id'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      children: [
                                        expansionTableData(
                                          'User Id',
                                          documentSnapshot['user_id'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Name',
                                          documentSnapshot['name'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Purchased At',
                                          documentSnapshot['date_time'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Purchased Value',
                                          documentSnapshot['value'],
                                          context,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    const Divider(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Earning Details"),
                                                    Text("Rohit Rai"),
                                                  ],
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 80,
                                                            child: Text(
                                                              "Date",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child: Text(
                                                                "Course Name",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child: Text(
                                                                "Course Shared",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child: Text(
                                                                "Amount credit",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child: Text(
                                                                "Total Earnings",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      StreamBuilder<Object>(
                                                          stream: null,
                                                          builder: (context,
                                                              snapshot) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: 80,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "2/03/2023",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.4),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "insta users",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.4),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "100",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.4),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "2000",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.4),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "2000",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.4),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Center(
                                              child: documentSnapshot[
                                                          'user_id'] !=
                                                      null
                                                  ? Text(
                                                      documentSnapshot[
                                                          'user_id'],
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : Text(
                                                      '',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          documentSnapshot['name'] != null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot['name'],
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          documentSnapshot['date_time'] != null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'date_time'],
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          documentSnapshot['value'] != null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot['value'],
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
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
    );
  }

  dashboardTile(stream, title, icon) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        if (value) {
          setState(
            () {},
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: greenShadeColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: greenLightShadeColor,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: stream == 'affilate_dashboard'
                      ? FirebaseFirestore.instance
                          .collection(stream)
                          .doc('NkcdMPSuI3SSIpJ2uLuv')
                          .collection('affiliate_users')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection(stream)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return Text(
                        streamSnapshot.data!.docs.length.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Text(
                      '0',
                      style: TextStyle(
                        fontSize: 50,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 120,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              color: greenLightShadeColor,
              size: displayWidth(context) < 1200 ? 80 : 120,
            ),
          ],
        ),
      ),
    );
  }
}
