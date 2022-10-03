import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool showAllUsers = false;
  bool showApprovedUsers = false;
  bool showUnApprovedUsers = false;
  bool showRejectedUsers = false;

  String userCount = '';
  String approvedUser = '';
  String unapprovedUser = '';
  String rejectedUser = '';

  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  Future<void> getUserCount() async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot snapshot) {
      log('user id is ${snapshot.docs.length}');
      setState(() {
        userCount = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> unapprovedUserCount() async {
    FirebaseFirestore.instance
        .collection('users').where('approval_status', isEqualTo: 'unapproved')
        .get()
        .then((QuerySnapshot snapshot) {
      log('unapproved user id is ${snapshot.docs.length}');
      setState(() {
        unapprovedUser = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> approvedUserCount() async {
    FirebaseFirestore.instance
        .collection('users').where('approval_status', isEqualTo: 'approved')
        .get()
        .then((QuerySnapshot snapshot) {
      log('approved user id is ${snapshot.docs.length}');
      setState(() {
        approvedUser = '${snapshot.docs.length}';
      });
    });
  }

  Future<void> rejectedUserCount() async {
    FirebaseFirestore.instance
        .collection('users').where('approval_status', isEqualTo: 'rejected')
        .get()
        .then((QuerySnapshot snapshot) {
      log('rejected user id is ${snapshot.docs.length}');
      setState(() {
        rejectedUser = '${snapshot.docs.length}';
      });
    });
  }

  @override
  void initState() {
    getUserCount();
    rejectedUserCount();
    approvedUserCount();
    unapprovedUserCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardTile(
                userCount,
                'All Users',
                Icons.groups,
              ),
              const SizedBox(width: 20),
              dashboardTile(
               approvedUser,
                'Approved Users',
                Icons.verified_user_sharp,
              ),
              const SizedBox(width: 20),
              dashboardTile(
                unapprovedUser,
                'Un-Approved Users',
                Icons.no_accounts,
              ),
              const SizedBox(width: 20),
              dashboardTile(
                rejectedUser,
                'Rejected Users',
                Icons.thumb_down,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
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
              children: [
                Container(
                  width: displayWidth(context) / 1.2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: greenShadeColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    'All Users :-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: SizedBox(
                        width: displayWidth(context) / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "User Id",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
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
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Center(
                                child: Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Center(
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Center(
                                child: Text(
                                  "Social Account",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Center(
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
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
                      padding: const EdgeInsets.all(10),
                      height: displayHeight(context) / 2.3,
                      width: displayWidth(context) / 1.2,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: StreamBuilder(
                            stream: user.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    documentSnapshot['user_Id'],
                                                    style: TextStyle(
                                                      color: Colors.black
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
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                      color: Colors.black
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
                                                    documentSnapshot[
                                                        'phone_number'],
                                                    style: TextStyle(
                                                      color: Colors.black
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
                                                    documentSnapshot['address'],
                                                    style: TextStyle(
                                                      color: Colors.black
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
                                                    documentSnapshot[
                                                        'social_account'],
                                                    style: TextStyle(
                                                      color: Colors.black
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
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color:documentSnapshot['approval_status'] == "approved"
                                                          ? greenLightShadeColor
                                                          : mainShadeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      documentSnapshot['approval_status'] == "approved"
                                                          ? "Approved"
                                                          : "Unapproved",
                                                      style: TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dashboardTile(count, title, icon) {
    return Container(
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 50,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
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
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Icon(
              icon,
              color: greenLightShadeColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
