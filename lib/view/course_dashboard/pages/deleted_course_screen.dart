import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class DeletedCourseScreen extends StatefulWidget {
  const DeletedCourseScreen({super.key});

  @override
  State<DeletedCourseScreen> createState() => _DeletedCourseScreenState();
}

class _DeletedCourseScreenState extends State<DeletedCourseScreen> {
  TextEditingController searchController = TextEditingController();
  String searchId = '';

  Query<Map<String, dynamic>> courses = FirebaseFirestore.instance
      .collection('courses')
      .where('status', isEqualTo: 'delete');

  Future<void> updateCoursesStatus(courseId) async {
    FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .update({'status': 'unapproved'});
  }

  Future<void> deleteCoures(courseId) async {
    FirebaseFirestore.instance.collection('courses').doc(courseId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          displayWidth(context) < 600 || displayWidth(context) < 1200
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Deleted Courses :-',
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
                            hintText: 'Enter course id to search',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 10),
          Container(
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
                Container(
                  decoration: BoxDecoration(
                    color: greenShadeColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
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
                                'Rejected Courses :-',
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
                                    hintText: 'Enter course id to search',
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
                                    "Course Id",
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
                                    "Course Name",
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
                                    "Views",
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
                                    "Purchases",
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
                                    "Uploaded By",
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
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: displayWidth(context) < 600 ||
                          displayWidth(context) < 1200
                      ? null
                      : displayHeight(context) / 1.3,
                  child: StreamBuilder(
                    stream: searchController.text.isEmpty
                        ? courses.snapshots()
                        : courses
                            .where(
                              'course_id',
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
                            return displayWidth(context) < 600 ||
                                    displayWidth(context) < 1200
                                ? Column(
                                    children: [
                                      ExpansionTile(
                                        tilePadding: const EdgeInsets.all(6),
                                        title: SelectableText(
                                          documentSnapshot.id,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        children: [
                                          expansionTableData(
                                            'Course Name',
                                            documentSnapshot['name'],
                                            context,
                                          ),
                                          expansionTableData(
                                            'Views',
                                            documentSnapshot['views'],
                                            context,
                                          ),
                                          expansionTableData(
                                            'Purchases',
                                            documentSnapshot['purchases'],
                                            context,
                                          ),
                                          expansionTableData(
                                            'Uploaded By',
                                            documentSnapshot['uploaded_by'],
                                            context,
                                          ),
                                          Container(
                                            width: displayWidth(context),
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40,
                                                vertical: 20,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  buttons(documentSnapshot),
                                                ],
                                              ),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: Center(
                                                child: SelectableText(
                                                  documentSnapshot.id,
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
                                                  documentSnapshot['name'],
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
                                                  documentSnapshot['views'],
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
                                                  documentSnapshot['purchases'],
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
                                                      'uploaded_by'],
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            buttons(documentSnapshot),
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buttons(DocumentSnapshot<Object?> documentSnapshot) {
    return Row(
      children: [
        MaterialButton(
          color: Colors.yellow,
          onPressed: () {
            updateCoursesStatus(documentSnapshot.id);
          },
          child: const Text(
            'Restore',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 5),
        MaterialButton(
          color: mainColor,
          onPressed: () {
            deleteCoures(documentSnapshot.id);
          },
          child: Text(
            'Permanent Delete',
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
