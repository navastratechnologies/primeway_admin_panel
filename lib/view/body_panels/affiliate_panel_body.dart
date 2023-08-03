import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AffiliatePanelBody extends StatefulWidget {
  const AffiliatePanelBody({super.key});

  @override
  State<AffiliatePanelBody> createState() => _AffiliatePanelBodyState();
}

class _AffiliatePanelBodyState extends State<AffiliatePanelBody> {
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
            : SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    mainBody(),
                  ],
                ),
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
          const SizedBox(
            height: 30,
          ),
          ResponsiveGridList(
            horizontalGridSpacing: 15,
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
                'users',
                'All Affiliate Users',
                Icons.person_pin,
              ),
              dashboardTile(
                'courses',
                'Affiliate Courses',
                Icons.menu_book_rounded,
              ),
              dashboardTile(
                'Earnings',
                "Member's Earnings",
                Icons.currency_rupee_rounded,
              ),
            ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      "Transaction Id",
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
                      "Wallet Balance",
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
                      "Requested For",
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
                                      title: SelectableText(
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
                                          'Wallet Balance',
                                          documentSnapshot['wallet_balance'],
                                          context,
                                        ),
                                        expansionTableData(
                                          'Requested For',
                                          documentSnapshot['requested_for'],
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Center(
                                            child: documentSnapshot[
                                                        'user_Id'] !=
                                                    null
                                                ? SelectableText(
                                                    documentSnapshot['user_Id'],
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : SelectableText(
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
                                                  child: SelectableText(
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
                                                  child: SelectableText(
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
                                        documentSnapshot['transaction_Id'] !=
                                                null
                                            ? SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: SelectableText(
                                                    documentSnapshot[
                                                        'transaction_Id'],
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
                                                  child: SelectableText(
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
                                                  child: SelectableText(
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
                                                  child: SelectableText(
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
                                        documentSnapshot['requested_for'] !=
                                                null
                                            ? SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: SelectableText(
                                                    documentSnapshot[
                                                        'requested_for'],
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
                                                  child: SelectableText(
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
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: documentSnapshot[
                                                                  'status'] ==
                                                              'approved'
                                                          ? greenLightShadeColor
                                                          : mainShadeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: SelectableText(
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
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: SelectableText(
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
              size: displayWidth(context) < 1200 ? 80 : 120,
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
