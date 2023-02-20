import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class OtherRequestScreen extends StatefulWidget {
  const OtherRequestScreen({super.key});

  @override
  State<OtherRequestScreen> createState() => _OtherRequestScreenState();
}

class _OtherRequestScreenState extends State<OtherRequestScreen> {
  final CollectionReference otherRequested =
      FirebaseFirestore.instance.collection('other_requests');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: greenShadeColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: displayWidth(context) < 600
                    ? Row(
                        children: [
                          Text(
                            'Other Requests :-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
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
                            width: 200,
                            child: Center(
                              child: Text(
                                "Requested For",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Center(
                              child: Text(
                                "Message",
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
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: displayHeight(context) / 1.25,
                    child: StreamBuilder(
                        stream: otherRequested.snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return displayWidth(context) < 600
                                    ? Column(
                                        children: [
                                          ExpansionTile(
                                            tilePadding:
                                                const EdgeInsets.all(6),
                                            title: SelectableText(
                                              documentSnapshot.id,
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            children: [
                                              expansionTableData(
                                                'User Name',
                                                documentSnapshot['user_name'],
                                                context,
                                              ),
                                              expansionTableData(
                                                'Requested For',
                                                documentSnapshot[
                                                    'requested_for'],
                                                context,
                                              ),
                                              expansionTableData(
                                                'Message',
                                                documentSnapshot['message'],
                                                context,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    MaterialButton(
                                                      color: mainColor,
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Contact',
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          const Divider(),
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 80,
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
                                                SizedBox(
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
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Center(
                                                    child: Text(
                                                      documentSnapshot[
                                                          'message'],
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
                                                  width: 200,
                                                  child: Center(
                                                    child: Text(
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
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        "Contact",
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
            ],
          ),
        ),
      ),
    );
  }
}
