import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class AffiliatePanelBodyEarnings extends StatefulWidget {
  const AffiliatePanelBodyEarnings({super.key});

  @override
  State<AffiliatePanelBodyEarnings> createState() =>
      _AffiliatePanelBodyEarningsState();
}

class _AffiliatePanelBodyEarningsState
    extends State<AffiliatePanelBodyEarnings> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Courses Sold :',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('courses')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                '0',
                                style: TextStyle(
                                  color: greenShadeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 200,
                                ),
                              ); // Display a loading indicator while data is being fetched.
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            // Calculate the total purchase amount
                            int totalPurchase = 0;
                            for (var doc in snapshot.data!.docs) {
                              totalPurchase += int.parse(doc['purchases']);
                            }

                            return Text(
                              '$totalPurchase',
                              style: TextStyle(
                                color: greenShadeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 200,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Text(
                            'This Month',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Earning :',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('courses')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                '00',
                                style: TextStyle(
                                  color: purpleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 200,
                                ),
                              ); // Display a loading indicator while data is being fetched.
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            // Calculate the total purchase amount
                            double totalCollection = 0.0;
                            for (var doc in snapshot.data!.docs) {
                              totalCollection +=
                                  double.parse(doc['total_collection']);
                            }

                            return Text(
                              '$rupeeSign$totalCollection',
                              style: TextStyle(
                                color: purpleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 200,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Text(
                            'This Month',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
