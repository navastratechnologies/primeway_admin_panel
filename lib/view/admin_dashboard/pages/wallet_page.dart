// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/format_numbers.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showUsers = false;
  bool showTransactions = true;
  String walletCount = '';
  int totalWalletBalance = 0;

  TextEditingController walletSearchController = TextEditingController();
  TextEditingController transactionSearchController = TextEditingController();
  String walletSearchId = '';
  String transactionSearchId = '';

  TextEditingController addPcoin = TextEditingController();
  TextEditingController minPcoin = TextEditingController();

  final CollectionReference wallet =
      FirebaseFirestore.instance.collection('wallet');

  String transCount = '';

  List data = [];

  Future<void> updateWalletStatus(id) async {
    FirebaseFirestore.instance
        .collection('wallet')
        .doc(id)
        .update({'status': 'approved'});
  }

  Future<void> updateWallet(id) async {
    FirebaseFirestore.instance
        .collection('wallet')
        .doc(id)
        .update({'status': 'completed'});
  }

  Future<void> addPcoins(id, walletBalance) async {
    int totalPCoins = int.parse(addPcoin.text) + int.parse(walletBalance);
    FirebaseFirestore.instance.collection('wallet').doc(id).update(
      {
        'wallet_balance': totalPCoins.toString(),
      },
    );
    setState(() {
      addPcoin.clear();
    });
  }

  Future<void> minPcoins(id, walletBalance) async {
    if (int.parse(walletBalance) > int.parse(minPcoin.text)) {
      int totalPCoins = int.parse(walletBalance) - int.parse(minPcoin.text);
      FirebaseFirestore.instance.collection('wallet').doc(id).update(
        {
          'wallet_balance': totalPCoins.toString(),
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: SelectableText('Wallet Balance is $walletBalance'),
        ),
      );
    }
    setState(() {
      minPcoin.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveGridList(
                horizontalGridSpacing: 10,
                minItemWidth: displayWidth(context) < 600
                    ? displayWidth(context)
                    : displayWidth(context) / 2.5,
                listViewBuilderOptions: ListViewBuilderOptions(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showUsers = true;
                        showTransactions = false;
                      });
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('wallet')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          double totalBalance = 0.0;
                          for (var i = 0;
                              i < streamSnapshot.data!.docs.length;
                              i++) {
                            totalBalance += double.tryParse(streamSnapshot
                                    .data!.docs[i]['wallet_balance']) ??
                                0;
                          }
                          final formattedBalance = formatNumber(totalBalance);
                          return dashboardTile(
                            formattedBalance,
                            'Total P Coins',
                            "Available In User's Wallet",
                            Icons.paid,
                          );
                        }
                        return dashboardTile(
                          '0',
                          'Total P Coins',
                          "Available In User's Wallet",
                          Icons.paid,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showUsers = false;
                        showTransactions = true;
                      });
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('withdrawal_request')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          final formattedBalance = formatNumber(
                            double.parse(
                              streamSnapshot.data!.docs.length.toString(),
                            ),
                          );
                          return dashboardTile(
                            formattedBalance,
                            'Total Transactions',
                            "All Time Transactions",
                            Icons.point_of_sale,
                          );
                        }
                        return dashboardTile(
                          '0',
                          'Total Transactions',
                          "All Time Transactions",
                          Icons.point_of_sale,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? Column(
                      children: [
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
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            backgroundColor: purpleColor,
                            collapsedBackgroundColor: purpleColor,
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              "All User's Wallet",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: [
                              walletTable(context),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
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
                              "All Transactions",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: [
                              transactionTable(context),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: walletTable(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: transactionTable(context),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  walletTable(BuildContext context) {
    return Container(
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
              color: displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? purpleColor
                  : greenShadeColor,
              borderRadius:
                  displayWidth(context) < 600 || displayWidth(context) < 1200
                      ? BorderRadius.circular(0)
                      : const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
            ),
            padding: const EdgeInsets.all(10),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Container(
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
                      controller: walletSearchController,
                      onChanged: (value) {
                        setState(() {
                          walletSearchId = walletSearchController.text;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          walletSearchId = walletSearchController.text;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter user id to search wallet',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            "All User's Wallet",
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
                              controller: walletSearchController,
                              onChanged: (value) {
                                setState(() {
                                  walletSearchId = walletSearchController.text;
                                });
                              },
                              onEditingComplete: () {
                                setState(() {
                                  walletSearchId = walletSearchController.text;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
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
                                "User Name",
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
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.65,
            width: displayWidth(context) / 1.1,
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: StreamBuilder(
                stream: walletSearchController.text.isEmpty
                    ? FirebaseFirestore.instance
                        .collection('wallet')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('wallet')
                        .where(
                          'user_id',
                          isEqualTo: walletSearchId,
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
                        return displayWidth(context) < 600 ||
                                displayWidth(context) < 1200
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ExpansionTile(
                                    tilePadding: const EdgeInsets.all(6),
                                    title: SelectableText(
                                      documentSnapshot['user_id'],
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
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
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(20),
                                        child: addDeductPCointButton(
                                          context,
                                          documentSnapshot,
                                        ),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['user_id'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['user_name'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot[
                                                  'wallet_balance'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        addDeductPCointButton(
                                          context,
                                          documentSnapshot,
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

  transactionTable(BuildContext context) {
    return Container(
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
              color: displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? purpleColor
                  : greenShadeColor,
              borderRadius:
                  displayWidth(context) < 600 || displayWidth(context) < 1200
                      ? BorderRadius.circular(0)
                      : const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
            ),
            padding: const EdgeInsets.all(10),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Container(
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
                      controller: transactionSearchController,
                      onChanged: (value) {
                        setState(() {
                          transactionSearchId =
                              transactionSearchController.text;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          transactionSearchId =
                              transactionSearchController.text;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter user id to search transaction',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            "All transactions",
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
                              controller: transactionSearchController,
                              onChanged: (value) {
                                setState(() {
                                  transactionSearchId =
                                      transactionSearchController.text;
                                });
                              },
                              onEditingComplete: () {
                                setState(() {
                                  transactionSearchId =
                                      transactionSearchController.text;
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
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                "User Name",
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
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.65,
            width: displayWidth(context) / 1.1,
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: StreamBuilder(
                stream: transactionSearchController.text.isEmpty
                    ? FirebaseFirestore.instance
                        .collection('withdrawal_request')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('withdrawal_request')
                        .where(
                          'transaction_Id',
                          isEqualTo: transactionSearchId,
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
                        return displayWidth(context) < 600 ||
                                displayWidth(context) < 1200
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ExpansionTile(
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
                                        'Name',
                                        documentSnapshot['user_name'],
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
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(20),
                                        child: acceptButton(
                                          documentSnapshot,
                                        ),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot[
                                                  'transaction_Id'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['user_name'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: SelectableText(
                                              documentSnapshot['requested_for'],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        acceptButton(documentSnapshot),
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

  addDeductPCointButton(context, documentSnapshot) {
    return Center(
      child: Row(
        children: [
          MaterialButton(
            color: greenShadeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    color: whiteColor,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: MaterialButton(
                            minWidth: 0,
                            height: 0,
                            padding: const EdgeInsets.all(14),
                            color: greenShadeColor,
                            shape: const CircleBorder(),
                            onPressed: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: displayWidth(context) < 600
                              ? displayWidth(context) / 1.2
                              : displayWidth(context) < 1200
                                  ? displayWidth(context) / 3
                                  : displayWidth(context) / 5,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 120,
                                        child: SelectableText(
                                          'User Id :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 160,
                                        child: SelectableText(
                                          documentSnapshot['user_id'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 120,
                                        child: SelectableText(
                                          'Username :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 160,
                                        child: SelectableText(
                                          documentSnapshot['user_name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 120,
                                        child: SelectableText(
                                          'Available Wallet Balance :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      '${documentSnapshot['wallet_balance']}'
                                              .isNotEmpty
                                          ? SizedBox(
                                              width: 160,
                                              child: SelectableText(
                                                '${documentSnapshot['wallet_balance']} P Coins',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 160,
                                              child: SelectableText(
                                                '0 P Coins',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Add P Coin :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: greenLightShadeColor,
                                        ),
                                        child: TextFormField(
                                          controller: addPcoin,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
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
                              const SizedBox(height: 20),
                              MaterialButton(
                                color: greenShadeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  addPcoins(documentSnapshot.id,
                                      documentSnapshot['wallet_balance']);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Add P Coins',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
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
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          MaterialButton(
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    color: whiteColor,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: MaterialButton(
                            minWidth: 0,
                            height: 0,
                            padding: const EdgeInsets.all(14),
                            color: greenShadeColor,
                            shape: const CircleBorder(),
                            onPressed: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: displayWidth(context) / 3,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 180,
                                        child: SelectableText(
                                          'User Id :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 200,
                                        child: SelectableText(
                                          documentSnapshot['user_id'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 180,
                                        child: SelectableText(
                                          'Username :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 200,
                                        child: SelectableText(
                                          documentSnapshot['user_name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 180,
                                        child: SelectableText(
                                          'Available Wallet Balance :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 200,
                                        child: SelectableText(
                                          '${documentSnapshot['wallet_balance']} P Coins',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Deduct P Coin :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      Container(
                                        width: 200,
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: mainShadeColor,
                                        ),
                                        child: TextFormField(
                                          controller: minPcoin,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
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
                              const SizedBox(height: 20),
                              MaterialButton(
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  minPcoins(documentSnapshot.id,
                                      documentSnapshot['wallet_balance']);
                                  Navigator.pop(context);
                                },
                                child: SelectableText(
                                  'Deduct P Coins',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
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
            },
            child: Text(
              'Deduct',
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

  dashboardTile(
    count,
    title,
    subTitle,
    icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: greenShadeColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greenShadeColor,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SelectableText(
                    count,
                    style: TextStyle(
                      fontSize: 50,
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SelectableText(
                    '/',
                    style: TextStyle(
                      fontSize: 50,
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: displayWidth(context) > 1200
                        ? Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: whiteColor.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : SizedBox(
                            width: displayWidth(context) < 600
                                ? displayWidth(context) / 4
                                : displayWidth(context) / 7.5,
                            child: Text(
                              subTitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: whiteColor.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
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
              size: 90,
            ),
          ),
        ],
      ),
    );
  }

  acceptButton(documentSnapshot) {
    return MaterialButton(
      color: greenShadeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 400,
              color: whiteColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      minWidth: 0,
                      height: 0,
                      padding: const EdgeInsets.all(14),
                      color: greenShadeColor,
                      shape: const CircleBorder(),
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: displayWidth(context) / 3,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Transaction Id :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    '1000111',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Account Holder Name :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['account_holder_name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Bank Name :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['bank_name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Account Number :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['account_number'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'IFSC Code :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['ifsc_code'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Available Wallet Balance :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['wallet_balance'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 180,
                                  child: SelectableText(
                                    'Withdrawl Request For :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    documentSnapshot['withdrawal_req'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            MaterialButton(
                              color: orange,
                              onPressed: () {
                                updateWalletStatus(documentSnapshot.id);
                                Navigator.pop(context);
                              },
                              child: SelectableText(
                                'Accept Withdrawal Request',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            MaterialButton(
                              color: yellow,
                              onPressed: () {
                                updateWallet(documentSnapshot.id);
                                Navigator.pop(context);
                              },
                              child: SelectableText(
                                'Mark Payment Done',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
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
          },
        );
      },
      child: Text(
        "Accept",
        style: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
