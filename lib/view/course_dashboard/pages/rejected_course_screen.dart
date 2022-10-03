import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class RejectedCourseScreen extends StatefulWidget {
  const RejectedCourseScreen({super.key});

  @override
  State<RejectedCourseScreen> createState() => _RejectedCourseScreenState();
}

class _RejectedCourseScreenState extends State<RejectedCourseScreen> {
  String rejectedCourses = '';

   Query<Map<String, dynamic>> courses =
      FirebaseFirestore.instance.collection('courses').where('status', isEqualTo: 'rejected');


   Future<void> updateCoursesStatus(courseId) async {
    FirebaseFirestore.instance
        .collection('courses').doc(courseId).update({
          'status': 'approved'
        });
        
  }

  Future<void> deleteCoursesStatus(courseId) async {
    FirebaseFirestore.instance
        .collection('courses').doc(courseId).update({
          'status': 'delete'
        });
        
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
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
                          "Course Id",
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
                          "Course Name",
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
                          "Views",
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
                          "Purchases",
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
                          "Uploaded By",
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
                          "Action",
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
              height: displayHeight(context) / 1.21,
              width: displayWidth(context) / 1.2,
              child: StreamBuilder(
                  stream: courses.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
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
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          documentSnapshot['views'],
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          documentSnapshot['purchases'],
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          documentSnapshot['uploaded_by'],
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          color: greenShadeColor,
                                          onPressed: () {
                                            updateCoursesStatus(documentSnapshot.id);
                                          },
                                          child: Text(
                                            'Approve This',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            deleteCoursesStatus(documentSnapshot.id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: mainColor,
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
      ),
    );
  }
}
