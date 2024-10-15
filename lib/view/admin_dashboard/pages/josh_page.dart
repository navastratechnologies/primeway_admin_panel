import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class JoshScreen extends StatefulWidget {
  const JoshScreen({super.key});

  @override
  State<JoshScreen> createState() => _JoshScreenState();
}

class _JoshScreenState extends State<JoshScreen> {
  bool showAllUsers = false;
  bool showApprovedUsers = false;
  bool showUnApprovedUsers = false;
  bool showRejectedUsers = false;

  String searchId = '';
  TextEditingController searchController = TextEditingController();

  final CollectionReference joshPurchase =
      FirebaseFirestore.instance.collection('josh_purchase');

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                          'All Requests :-',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              color: purpleColor,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () => showPackagesDialog(context),
                              child: const Text(
                                'View Josh Packages',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            MaterialButton(
                              color: purpleColor,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () => showCustomDialog(context),
                              child: const Text(
                                'Add Josh Packages',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
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
                      ],
                    ),
              const SizedBox(height: 20),
              displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? Column(
                      children: [
                        MaterialButton(
                          color: purpleColor,
                          minWidth: displayWidth(context),
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => showPackagesDialog(context),
                          child: const Text(
                            'View Josh Packages',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          color: purpleColor,
                          minWidth: displayWidth(context),
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => showCustomDialog(context),
                          child: const Text(
                            'Add Josh Packages',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : const SizedBox(),
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
                                  'All Requests :-',
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
                                      "Payment Id",
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
                                      "Josh Id",
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
                                      "Amount",
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
                                      "Coins",
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
                        stream: joshPurchase.snapshots(),
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
                                if (documentSnapshot['user_id']
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
                                                documentSnapshot['user_id'],
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              children: [
                                                expansionTableData(
                                                  'Payment Id',
                                                  documentSnapshot[
                                                      'payment_id'],
                                                  context,
                                                ),
                                                expansionTableData(
                                                  'Josh Id',
                                                  documentSnapshot['josh_id'],
                                                  context,
                                                ),
                                                expansionTableData(
                                                  'Amount',
                                                  documentSnapshot['amount'],
                                                  context,
                                                ),
                                                expansionTableData(
                                                  'Coins',
                                                  documentSnapshot['coins']
                                                      .toString(),
                                                  context,
                                                ),
                                                expansionTableData(
                                                  'Status',
                                                  documentSnapshot['status']
                                                      .toString(),
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
                                                  documentSnapshot['user_id'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'user_id'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  documentSnapshot[
                                                              'payment_id'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'payment_id'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  documentSnapshot['josh_id'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'josh_id'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  documentSnapshot['amount'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'amount'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  documentSnapshot['coins'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'coins'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  documentSnapshot['status'] !=
                                                          null
                                                      ? SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              documentSnapshot[
                                                                  'status'],
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
                                                        )
                                                      : SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child:
                                                                SelectableText(
                                                              '',
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
                                                  Column(
                                                    children: [
                                                      MaterialButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 14,
                                                        ),
                                                        onPressed: () {
                                                          joshPurchase
                                                              .doc(
                                                                  documentSnapshot
                                                                      .id)
                                                              .update({
                                                            'status':
                                                                'accepted',
                                                          });
                                                        },
                                                        color: greenShadeColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Text(
                                                          'Accept',
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      MaterialButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 14,
                                                        ),
                                                        onPressed: () {
                                                          joshPurchase
                                                              .doc(
                                                                  documentSnapshot
                                                                      .id)
                                                              .update({
                                                            'status':
                                                                'rejected',
                                                          });
                                                        },
                                                        color: mainColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Text(
                                                          'Reject',
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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

  void showCustomDialog(BuildContext context) {
    final TextEditingController fieldOneController = TextEditingController();
    final TextEditingController fieldTwoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add Josh Package'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: fieldOneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Price',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: fieldTwoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Coin Value',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              color: greenLightShadeColor,
              child: const Text('Add'),
              onPressed: () {
                if (fieldOneController.text.isNotEmpty &&
                    fieldTwoController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection('josh_packages').add(
                    {
                      "package_price": fieldOneController.text,
                      "package_value": fieldTwoController.text,
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Package added successfully!'),
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all details to continue'),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showPackagesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Packages List'),
          content: SizedBox(
            width: double.maxFinite,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('josh_packages')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Text('No packages found');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var package = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        splashColor: purpleColor,
                        hoverColor: purpleColor,
                        title: Text(
                          "Package Price: ${package['package_price']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Package Value: ${package['package_value']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('josh_packages')
                                .doc(package.id)
                                .delete()
                                .then((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Package deleted successfully'),
                              ));
                            }).catchError((error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Failed to delete package: $error'),
                              ));
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
