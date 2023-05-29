import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:lottie/lottie.dart';
import 'package:primeway_admin_panel/view/course_dashboard/edit_course_info.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courseinfo.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final CollectionReference course =
      FirebaseFirestore.instance.collection('courses');

  TextEditingController affiliatePriceController = TextEditingController();

  bool showCourseInfoPage = false;

  String courseId = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height / 1.12,
      width: width,
      child: showCourseInfoPage
          ? StreamBuilder(
              stream:
                  course.where('course_id', isEqualTo: courseId).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  children: [
                                    MaterialButton(
                                      color: purpleColor,
                                      padding: const EdgeInsets.all(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () => setState(
                                        () => showCourseInfoPage = false,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_rounded,
                                            color: whiteColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Go Back',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    MaterialButton(
                                      color: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('courses')
                                            .doc(courseId)
                                            .update(
                                          {
                                            'status': 'rejected',
                                            'islive': 'false',
                                          },
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Reject',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    MaterialButton(
                                      color: greenShadeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('courses')
                                            .doc(courseId)
                                            .update(
                                          {
                                            'status': 'approved',
                                            'islive': 'true',
                                          },
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Approve',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: displayWidth(context) < 600 ||
                                        displayWidth(context) < 1200
                                    ? displayWidth(context)
                                    : displayWidth(context) / 1.2,
                                height: displayHeight(context) / 1.3,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: greenShadeColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: mainColor.withOpacity(0.1),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                displayWidth(context) < 600
                                                    ? const SizedBox()
                                                    : SizedBox(
                                                        height: 200,
                                                        width: 200,
                                                        child: Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: 200,
                                                              width: 200,
                                                              child:
                                                                  Image.network(
                                                                streamSnapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['image'],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            streamSnapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'isInAffiliate'] ==
                                                                    "false"
                                                                ? Container()
                                                                : Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              32,
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                purpleColor,
                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Image.asset(
                                                                                'assets/affiliate.png',
                                                                                height: 20,
                                                                                width: 20,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                              const SizedBox(width: 5),
                                                                              Text(
                                                                                "Is In Affiliate",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: whiteColor,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          displayWidth(
                                                                      context) <
                                                                  600
                                                              ? Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          200,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                200,
                                                                            child:
                                                                                Image.network(
                                                                              streamSnapshot.data!.docs[index]['image'],
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          streamSnapshot.data!.docs[index]['isInAffiliate'] == "false"
                                                                              ? Container()
                                                                              : Align(
                                                                                  alignment: Alignment.bottomLeft,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 32,
                                                                                        padding: const EdgeInsets.all(5),
                                                                                        decoration: BoxDecoration(
                                                                                          color: purpleColor,
                                                                                          borderRadius: const BorderRadius.only(
                                                                                            topLeft: Radius.circular(10),
                                                                                          ),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                          children: [
                                                                                            Image.asset(
                                                                                              'assets/affiliate.png',
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                            const SizedBox(width: 5),
                                                                                            Text(
                                                                                              "Is In Affiliate",
                                                                                              style: TextStyle(
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: whiteColor,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                                          Text(
                                                            '${streamSnapshot.data!.docs[index]['name']}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          SizedBox(
                                                            width: 300,
                                                            child: Text(
                                                              '${streamSnapshot.data!.docs[index]['short_description']}',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 5,
                                                              horizontal: 10,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  purpleColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: purpleColor
                                                                      .withOpacity(
                                                                          0.1),
                                                                  blurRadius:
                                                                      10,
                                                                  spreadRadius:
                                                                      1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Text(
                                                              'Rs. ${streamSnapshot.data!.docs[index]['base_ammount']}',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          InkWell(
                                                            onTap: () {
                                                              if (streamSnapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'isInAffiliate'] ==
                                                                  "false") {
                                                                // course
                                                                //     .doc(streamSnapshot
                                                                //         .data!.docs[index].id)
                                                                //     .update({
                                                                //   'isInAffiliate': 'true',
                                                                // });
                                                                showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      content:
                                                                          SizedBox(
                                                                        width:
                                                                            300,
                                                                        height:
                                                                            400,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Stack(
                                                                              children: [
                                                                                Lottie.asset('assets/json/affiliate.json'),
                                                                                Align(
                                                                                  alignment: Alignment.topRight,
                                                                                  child: MaterialButton(
                                                                                    color: mainColor,
                                                                                    shape: const CircleBorder(),
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                    child: Icon(
                                                                                      Icons.close_rounded,
                                                                                      color: whiteColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              padding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 1,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                color: whiteColor,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: greenShadeColor.withOpacity(0.6),
                                                                                    blurRadius: 10,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              child: TextFormField(
                                                                                controller: affiliatePriceController,
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                  hintText: 'Enter Affiliate Price In %',
                                                                                  hintStyle: TextStyle(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: Colors.black.withOpacity(0.5),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 20),
                                                                            MaterialButton(
                                                                              color: purpleColor,
                                                                              onPressed: () {
                                                                                course.doc(streamSnapshot.data!.docs[index].id).update({
                                                                                  'isInAffiliate': 'true',
                                                                                  'affiliate_price': affiliatePriceController.text,
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                'Make It Affiliate',
                                                                                style: TextStyle(
                                                                                  color: whiteColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                course
                                                                    .doc(streamSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id)
                                                                    .update({
                                                                  'isInAffiliate':
                                                                      'false',
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mainShadeColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: mainColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        10,
                                                                    spreadRadius:
                                                                        1,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text(
                                                                streamSnapshot
                                                                            .data!
                                                                            .docs[index]['isInAffiliate'] ==
                                                                        "false"
                                                                    ? 'Make This Course Affiliate'
                                                                    : 'Remove from Affiliate',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      whiteColor,
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
                                                          height: 10),
                                                      Container(
                                                        width: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 10,
                                                          horizontal: 20,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              greenShadeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: mainColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              blurRadius: 10,
                                                              spreadRadius: 1,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                EditCourseInfo(
                                                                          courseId: streamSnapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    'Edit',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          whiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: whiteColor
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                UploadCoursesScreen(
                                                                          courseId: streamSnapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id,
                                                                        ),
                                                                      ),
                                                                    );

                                                                    log('Course id is : ${streamSnapshot.data!.docs[index].id}');
                                                                  },
                                                                  child: Text(
                                                                    'Chapters',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          purpleColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: whiteColor
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    course
                                                                        .doc(streamSnapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id)
                                                                        .update({
                                                                      'status':
                                                                          'delete',
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 32,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: streamSnapshot.data!
                                                                    .docs[index]
                                                                ['islive'] ==
                                                            "false"
                                                        ? mainColor
                                                        : purpleColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Image.asset(
                                                        streamSnapshot.data!.docs[
                                                                        index][
                                                                    'islive'] ==
                                                                "false"
                                                            ? 'assets/file-icon.png'
                                                            : 'assets/live-icon.png',
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        streamSnapshot.data!.docs[
                                                                        index][
                                                                    'islive'] ==
                                                                "false"
                                                            ? "In Draft"
                                                            : "Is Live",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 32,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: greenShadeColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Switch(
                                                    value: streamSnapshot.data!
                                                                    .docs[index]
                                                                ['islive'] ==
                                                            "true"
                                                        ? true
                                                        : false,
                                                    activeColor: whiteColor,
                                                    activeTrackColor: Colors
                                                        .black
                                                        .withOpacity(0.3),
                                                    onChanged: (bool value) {
                                                      course
                                                          .doc(streamSnapshot
                                                              .data!
                                                              .docs[index]
                                                              .id)
                                                          .update({
                                                        'islive': '$value',
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          courseDetailsWidget(
                                            'Course Name :',
                                            documentSnapshot['name'],
                                          ),
                                          courseDetailsWidget(
                                            'Author Name :',
                                            documentSnapshot['author_name'],
                                          ),
                                          courseDetailsWidget(
                                            'Base Amount :',
                                            "Rs.${documentSnapshot['base_ammount']}",
                                          ),
                                          courseDetailsWidget(
                                            'Discount :',
                                            "${documentSnapshot['discount']}%",
                                          ),
                                          courseDetailsWidget(
                                            'GST :',
                                            "${documentSnapshot['gst_rate']}%",
                                          ),
                                          courseDetailsWidget(
                                            'Course Language :',
                                            documentSnapshot['language'],
                                          ),
                                          courseDetailsWidget(
                                            'course Description :',
                                            documentSnapshot[
                                                'course_description'],
                                          ),
                                          courseDetailsWidget(
                                            'course Short Description :',
                                            documentSnapshot[
                                                'short_description'],
                                          ),
                                          courseDetailsWidget(
                                            'Student Learn :',
                                            documentSnapshot['students_learn'],
                                          ),
                                          courseDetailsWidget(
                                            'Uploaded By :',
                                            documentSnapshot['uploaded_by'],
                                          ),
                                          courseDetailsWidget(
                                            'Course Validity :',
                                            documentSnapshot['validity'],
                                          ),
                                          courseDetailsWidget(
                                            'Course Chapters :',
                                            "${documentSnapshot['chapters']} Chapters",
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
                    },
                  );
                }
                return Container();
              },
            )
          : Column(
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: MaterialButton(
                      color: greenShadeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CoursesInfo(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'New Course',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: course
                        .where('status', isNotEqualTo: 'delete')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ResponsiveGridList(
                          horizontalGridSpacing: 10,
                          horizontalGridMargin: 10,
                          verticalGridMargin: 20,
                          minItemWidth: 400,
                          maxItemsPerRow: 3,
                          listViewBuilderOptions: ListViewBuilderOptions(),
                          children: List.generate(
                            streamSnapshot.data!.docs.length,
                            (index) => InkWell(
                              onTap: () => setState(() {
                                showCourseInfoPage = true;
                                courseId = streamSnapshot.data!.docs[index].id;
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: mainColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        displayWidth(context) < 600
                                            ? const SizedBox()
                                            : SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 300,
                                                      width: 200,
                                                      child: ImageNetwork(
                                                        image: streamSnapshot
                                                                .data!
                                                                .docs[index]
                                                            ['image'],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        imageCache:
                                                            CachedNetworkImageProvider(
                                                          streamSnapshot.data!
                                                                  .docs[index]
                                                              ['image'],
                                                        ),
                                                        height: 300,
                                                        width: 200,
                                                        fitWeb: BoxFitWeb.cover,
                                                      ),
                                                    ),
                                                    streamSnapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'isInAffiliate'] ==
                                                            "false"
                                                        ? Container()
                                                        : Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  height: 32,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        purpleColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'assets/affiliate.png',
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        "Is In Affiliate",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  displayWidth(context) < 600
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 200,
                                                              child: Stack(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 200,
                                                                    child: Image
                                                                        .network(
                                                                      streamSnapshot
                                                                          .data!
                                                                          .docs[index]['image'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  streamSnapshot
                                                                              .data!
                                                                              .docs[index]['isInAffiliate'] ==
                                                                          "false"
                                                                      ? Container()
                                                                      : Align(
                                                                          alignment:
                                                                              Alignment.bottomLeft,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Container(
                                                                                height: 32,
                                                                                padding: const EdgeInsets.all(5),
                                                                                decoration: BoxDecoration(
                                                                                  color: purpleColor,
                                                                                  borderRadius: const BorderRadius.only(
                                                                                    topLeft: Radius.circular(10),
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/affiliate.png',
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                    const SizedBox(width: 5),
                                                                                    Text(
                                                                                      "Is In Affiliate",
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: whiteColor,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  Text(
                                                    '${streamSnapshot.data!.docs[index]['name']}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    width: 300,
                                                    child: Text(
                                                      '${streamSnapshot.data!.docs[index]['short_description']}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: purpleColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: purpleColor
                                                              .withOpacity(0.1),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'Rs. ${streamSnapshot.data!.docs[index]['base_ammount']}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  InkWell(
                                                    onTap: () {
                                                      if (streamSnapshot.data!
                                                                  .docs[index][
                                                              'isInAffiliate'] ==
                                                          "false") {
                                                        // course
                                                        //     .doc(streamSnapshot
                                                        //         .data!.docs[index].id)
                                                        //     .update({
                                                        //   'isInAffiliate': 'true',
                                                        // });
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: SizedBox(
                                                                width: 300,
                                                                height: 400,
                                                                child: Column(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Lottie.asset(
                                                                            'assets/json/affiliate.json'),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              MaterialButton(
                                                                            color:
                                                                                mainColor,
                                                                            shape:
                                                                                const CircleBorder(),
                                                                            onPressed: () =>
                                                                                Navigator.pop(context),
                                                                            child:
                                                                                Icon(
                                                                              Icons.close_rounded,
                                                                              color: whiteColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            1,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            whiteColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                greenShadeColor.withOpacity(0.6),
                                                                            blurRadius:
                                                                                10,
                                                                            spreadRadius:
                                                                                1,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            affiliatePriceController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintText:
                                                                              'Enter Affiliate Price In %',
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    MaterialButton(
                                                                      color:
                                                                          purpleColor,
                                                                      onPressed:
                                                                          () {
                                                                        course
                                                                            .doc(streamSnapshot.data!.docs[index].id)
                                                                            .update({
                                                                          'isInAffiliate':
                                                                              'true',
                                                                          'affiliate_price':
                                                                              affiliatePriceController.text,
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Make It Affiliate',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        course
                                                            .doc(streamSnapshot
                                                                .data!
                                                                .docs[index]
                                                                .id)
                                                            .update({
                                                          'isInAffiliate':
                                                              'false',
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 5,
                                                        horizontal: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: mainShadeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: mainColor
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 10,
                                                            spreadRadius: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        streamSnapshot.data!.docs[
                                                                        index][
                                                                    'isInAffiliate'] ==
                                                                "false"
                                                            ? 'Make This Course Affiliate'
                                                            : 'Remove from Affiliate',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: 300,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: greenShadeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: mainColor
                                                          .withOpacity(0.1),
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditCourseInfo(
                                                                  courseId:
                                                                      streamSnapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: 1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: whiteColor
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UploadCoursesScreen(
                                                                  courseId:
                                                                      streamSnapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                ),
                                                              ),
                                                            );

                                                            log('Course id is : ${streamSnapshot.data!.docs[index].id}');
                                                          },
                                                          child: Text(
                                                            'Chapters',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  purpleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: 1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: whiteColor
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            course
                                                                .doc(streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'status':
                                                                  'delete',
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 32,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                streamSnapshot.data!.docs[index]
                                                            ['islive'] ==
                                                        "false"
                                                    ? mainColor
                                                    : purpleColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset(
                                                streamSnapshot.data!.docs[index]
                                                            ['islive'] ==
                                                        "false"
                                                    ? 'assets/file-icon.png'
                                                    : 'assets/live-icon.png',
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                streamSnapshot.data!.docs[index]
                                                            ['islive'] ==
                                                        "false"
                                                    ? "In Draft"
                                                    : "Is Live",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 32,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: greenShadeColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Switch(
                                            value:
                                                streamSnapshot.data!.docs[index]
                                                            ['islive'] ==
                                                        "true"
                                                    ? true
                                                    : false,
                                            activeColor: whiteColor,
                                            activeTrackColor:
                                                Colors.black.withOpacity(0.3),
                                            onChanged: (bool value) {
                                              course
                                                  .doc(streamSnapshot
                                                      .data!.docs[index].id)
                                                  .update({
                                                'islive': '$value',
                                              });
                                            },
                                          ),
                                        ),
                                      ],
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

  courseDetailsWidget(label, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: displayWidth(context) / 2,
            child: Text(
              data,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
