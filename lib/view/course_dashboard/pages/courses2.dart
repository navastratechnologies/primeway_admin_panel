import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/edit_course_info.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'courseinfo.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final CollectionReference course =
      FirebaseFirestore.instance.collection('courses');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
                elevation: 5.0,
                minWidth: 80.0,
                height: 45,
                color: Colors.green,
                child: const Text(
                  'New Unit',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CoursesInfo(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 650,
            width: 1200,
            child: StreamBuilder(
              stream:
                  course.where('status', isNotEqualTo: 'delete').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ResponsiveGridList(
                    horizontalGridSpacing: 16,
                    horizontalGridMargin: 10,
                    verticalGridMargin: 50,
                    minItemWidth: 600,
                    minItemsPerRow: 2,
                    maxItemsPerRow: 5,
                    listViewBuilderOptions: ListViewBuilderOptions(),
                    children: List.generate(
                      streamSnapshot.data!.docs.length,
                      (index) => Card(
                        child: Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mainColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 190,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            streamSnapshot.data!.docs[index]
                                                ['image'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${streamSnapshot.data!.docs[index]['name']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 360,
                                      child: Text(
                                        '${streamSnapshot.data!.docs[index]['short_description']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Daily Users',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Published',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditCourseInfo(
                                                  courseId: streamSnapshot
                                                      .data!.docs[index].id,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 60,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadCoursesScreen(
                                                  courseId: streamSnapshot
                                                      .data!.docs[index].id,
                                                ),
                                              ),
                                            );

                                            log('Course id is : ${streamSnapshot.data!.docs[index].id}');
                                          },
                                          child: const Text(
                                            'Lessons',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 60,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            course
                                                .doc(streamSnapshot
                                                    .data!.docs[index].id)
                                                .update({
                                              'status': 'delete',
                                            });
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
