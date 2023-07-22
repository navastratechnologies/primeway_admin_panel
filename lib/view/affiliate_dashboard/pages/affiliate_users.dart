import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AffiliatePanelBodyUsers extends StatefulWidget {
  const AffiliatePanelBodyUsers({super.key});

  @override
  State<AffiliatePanelBodyUsers> createState() =>
      _AffiliatePanelBodyUsersState();
}

class _AffiliatePanelBodyUsersState extends State<AffiliatePanelBodyUsers> {
  var data = {};
  String userCount = '';
  String coursesCount = '';
  String collaborationCount = '';

  String searchId = '';

  TextEditingController searchController = TextEditingController();

  final CollectionReference withDrawal =
      FirebaseFirestore.instance.collection('withdrawal_request');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
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
                  mainBody(),
                ],
              ),
      ),
    );
  }

  mainBody() {
    return Container(
      width: displayWidth(context) < 600 || displayWidth(context) < 1200
          ? displayWidth(context)
          : displayWidth(context) / 1.5,
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridList(
            horizontalGridSpacing: 10,
            minItemWidth:
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? 200
                    : 300,
            listViewBuilderOptions: ListViewBuilderOptions(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            children: [
              dashboardTile(
                'All Affiliate Users',
                'All Affiliate Users',
                Icons.person_pin,
              ),
              dashboardTile(
                'Approved Affiliate Users',
                'Approved Affiliate Users',
                Icons.person_pin,
              ),
              dashboardTile(
                'Rejected Affiliate Users',
                "Rejected Affiliate Users",
                Icons.person_pin,
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? displayWidth(context)
                : displayWidth(context) / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayWidth(context) < 600 || displayWidth(context) < 1200
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Affiliate User Requests :-',
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
                                hintText: 'Enter User id to search',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                adminTabel(context),
              ],
            ),
          ),
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
                            "Course Shared",
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
                            "Course Shared To users",
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
                            "Complete Course Shared",
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
                            "Affiliate Status",
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
          Container(
            padding: const EdgeInsets.all(10),
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.65,
            child: StreamBuilder(
                stream: searchController.text.isEmpty
                    ? withDrawal.snapshots()
                    : withDrawal
                        .where(
                          'transaction_Id',
                          isEqualTo: searchId,
                        )
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
                                        documentSnapshot['transaction_Id'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      children: [
                                        expansionTableData(
                                          'User Id',
                                          documentSnapshot['user_Id'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Name',
                                          documentSnapshot['user_name'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Wallet Balqance',
                                          documentSnapshot['wallet_balance'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Wallet Balanceq',
                                          documentSnapshot['wallet_balance'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Wallet Balancqe',
                                          documentSnapshot['wallet_balance'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Status',
                                          documentSnapshot['status'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Status',
                                          documentSnapshot['status'],
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
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: const [
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
                                                          'user_Id'] !=
                                                      null
                                                  ? Text(
                                                      documentSnapshot[
                                                          'user_Id'],
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
                                          documentSnapshot['user_name'] != null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'user_name'],
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
                                          documentSnapshot['wallet_balance'] !=
                                                  null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'wallet_balance'],
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
                                          documentSnapshot['wallet_balance'] !=
                                                  null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'wallet_balance'],
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
                                          documentSnapshot['wallet_balance'] !=
                                                  null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'wallet_balance'],
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
                                          documentSnapshot['status'] != null
                                              ? SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: documentSnapshot[
                                                                    'status'] ==
                                                                'approved'
                                                            ? greenLightShadeColor
                                                            : mainShadeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        documentSnapshot[
                                                                    'status'] ==
                                                                'approved'
                                                            ? "Approved"
                                                            : "Pending",
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        '',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 170,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          actionsPadding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                          title: const Text(
                                                            'Do you really want to approve this user for affiliate program?',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          actions: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'User approved for affiliate program.',
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              color:
                                                                  greenShadeColor,
                                                              child: Text(
                                                                'Yes',
                                                                style: TextStyle(
                                                                    color:
                                                                        whiteColor),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              color: mainColor,
                                                              child: Text(
                                                                'No',
                                                                style: TextStyle(
                                                                    color:
                                                                        whiteColor),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            greenLightShadeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        "Approve",
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      "Ban",
                                                      style: TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
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
