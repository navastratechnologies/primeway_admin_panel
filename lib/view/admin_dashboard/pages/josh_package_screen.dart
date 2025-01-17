import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class JoshPackageScreen extends StatefulWidget {
  const JoshPackageScreen({super.key});

  @override
  State<JoshPackageScreen> createState() => _JoshPackageScreenState();
}

class _JoshPackageScreenState extends State<JoshPackageScreen> {
  bool showAllUsers = false;
  bool showApprovedUsers = false;
  bool showUnApprovedUsers = false;
  bool showRejectedUsers = false;

  String searchId = '';
  TextEditingController searchController = TextEditingController();

  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            'All Users :-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          Container(
                            width: 400,
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
                                hintText: 'Enter user id to search',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: greenShadeColor,
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
                        child: displayWidth(context) < 600 ||
                                displayWidth(context) < 1200
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    'All Users :-',
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
                                        hintText: 'Enter user id to search',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: SelectableText(
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
                                      child: SelectableText(
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
                                      child: SelectableText(
                                        "Phone Number",
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
                                      child: SelectableText(
                                        "Address",
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
                                      child: SelectableText(
                                        "Social Account",
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
                                      child: SelectableText(
                                        "Status",
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
                        height: displayWidth(context) < 600 ||
                                displayWidth(context) < 1200
                            ? null
                            : displayHeight(context) / 1.85,
                        width: displayWidth(context) / 1.1,
                        decoration: BoxDecoration(
                          color: whiteColor,
                        ),
                        child: StreamBuilder(
                          stream: user.snapshots(),
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
                                  if (documentSnapshot['phone_number']
                                      .toString()
                                      .contains(searchId)) {
                                    return displayWidth(context) < 600 ||
                                            displayWidth(context) < 1200
                                        ? Column(
                                            children: [
                                              ExpansionTile(
                                                tilePadding:
                                                    const EdgeInsets.all(6),
                                                title: SelectableText(
                                                  documentSnapshot[
                                                      'phone_number'],
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                children: [
                                                  expansionTableData(
                                                    'Name',
                                                    documentSnapshot['name'],
                                                    context,
                                                  ),
                                                  expansionTableData(
                                                    'Phone Number',
                                                    documentSnapshot[
                                                        'phone_number'],
                                                    context,
                                                  ),
                                                  expansionTableData(
                                                    'Address',
                                                    documentSnapshot['address'],
                                                    context,
                                                  ),
                                                  expansionTableData(
                                                    'Social Accounts',
                                                    documentSnapshot[
                                                                'instagram_username']
                                                            .toString()
                                                            .isNotEmpty
                                                        ? documentSnapshot[
                                                            'instagram_username']
                                                        : documentSnapshot[
                                                                    'youtube_username']
                                                                .toString()
                                                                .isNotEmpty
                                                            ? documentSnapshot[
                                                                'youtube_username']
                                                            : 'No Account Linked Yet',
                                                    context,
                                                  ),
                                                  expansionTableData(
                                                    'Status',
                                                    documentSnapshot[
                                                        'approval_status'],
                                                    context,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              const Divider(),
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    documentSnapshot[
                                                                'user_Id'] !=
                                                            null
                                                        ? SizedBox(
                                                            width: 80,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                documentSnapshot[
                                                                    'user_Id'],
                                                                style:
                                                                    TextStyle(
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
                                                          )
                                                        : SizedBox(
                                                            width: 80,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                '',
                                                                style:
                                                                    TextStyle(
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
                                                    documentSnapshot['name'] !=
                                                            null
                                                        ? SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                documentSnapshot[
                                                                    'name'],
                                                                style:
                                                                    TextStyle(
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
                                                          )
                                                        : SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                '',
                                                                style:
                                                                    TextStyle(
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
                                                    documentSnapshot[
                                                                'phone_number'] !=
                                                            null
                                                        ? SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                documentSnapshot[
                                                                    'phone_number'],
                                                                style:
                                                                    TextStyle(
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
                                                          )
                                                        : SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                '',
                                                                style:
                                                                    TextStyle(
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
                                                    documentSnapshot[
                                                                'address'] !=
                                                            null
                                                        ? SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                documentSnapshot[
                                                                    'address'],
                                                                style:
                                                                    TextStyle(
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
                                                          )
                                                        : SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                '',
                                                                style:
                                                                    TextStyle(
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
                                                    documentSnapshot[
                                                                'instagram_username'] !=
                                                            null
                                                        ? SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                documentSnapshot[
                                                                    'instagram_username'],
                                                                style:
                                                                    TextStyle(
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
                                                          )
                                                        : SizedBox(
                                                            width: 120,
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                '',
                                                                style:
                                                                    TextStyle(
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
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: documentSnapshot[
                                                                        'approval_status'] ==
                                                                    "approved"
                                                                ? greenLightShadeColor
                                                                : documentSnapshot[
                                                                            'approval_status'] ==
                                                                        "rejected"
                                                                    ? mainShadeColor
                                                                    : yellow,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            documentSnapshot[
                                                                        'approval_status'] ==
                                                                    "approved"
                                                                ? "Approved"
                                                                : documentSnapshot[
                                                                            'approval_status'] ==
                                                                        "rejected"
                                                                    ? "Rejected"
                                                                    : "Unapproved",
                                                            style: TextStyle(
                                                              color: whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                            ),
                                          );
                                  }
                                  return null;
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dashboardTile(status, title, icon) {
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
                  stream: status == "all-users"
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where('approval_status', isEqualTo: status)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return SelectableText(
                        streamSnapshot.data!.docs.length.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return SelectableText(
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
                  child: SelectableText(
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
              size: 120,
            ),
          ],
        ),
      ),
    );
  }
}
