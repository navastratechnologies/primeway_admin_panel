import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/body_panels/course_panel_body.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/approved_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/deleted_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/live_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/rejected_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/unapproved_course_screen.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/top_bar.dart';

class CourseDashboard extends StatefulWidget {
  const CourseDashboard({super.key});

  @override
  State<CourseDashboard> createState() => _CourseDashboardState();
}

class _CourseDashboardState extends State<CourseDashboard> {
  bool showDashboardPanel = true;
  bool showLiveCourses = false;
  bool showPendingCourses = false;
  bool showApprovedCourses = false;
  bool showRejectedCourses = false;
  bool showUploadCourses = false;
  bool showDeleteCourses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        width: displayWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: mainColor,
                boxShadow: [
                  BoxShadow(
                    color: elevationColor,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          mainShadeColor,
                          mainColor,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: elevationColor,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    mainColor,
                                    mainShadeColor,
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Image(
                                image: AssetImage('assets/primeway-logo.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Primeway',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                      fontSize: 30),
                                ),
                                Text(
                                  'Skills Pvt. Ltd.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        width: displayWidth(context) / 6.27,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              elevation: 0,
                              color: showDashboardPanel
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = true;
                                  showApprovedCourses = false;
                                  showRejectedCourses = false;
                                  showUploadCourses = false;
                                  showLiveCourses = false;
                                  showPendingCourses = false;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home_rounded,
                                    color: showDashboardPanel
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color:
                                  showLiveCourses ? greenShadeColor : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = false;
                                  showRejectedCourses = false;
                                  showUploadCourses = false;
                                  showLiveCourses = true;
                                  showPendingCourses = false;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.stream,
                                    color: showLiveCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Live Courses',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color: showPendingCourses
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = false;
                                  showRejectedCourses = false;
                                  showUploadCourses = false;
                                  showLiveCourses = false;
                                  showPendingCourses = true;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.pending_actions_outlined,
                                    color: showPendingCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Un-Approved Courses',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color: showApprovedCourses
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = true;
                                  showRejectedCourses = false;
                                  showUploadCourses = false;
                                  showLiveCourses = false;
                                  showPendingCourses = false;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up_alt,
                                    color: showApprovedCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Approved Courses',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color: showRejectedCourses
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = false;
                                  showRejectedCourses = true;
                                  showUploadCourses = false;
                                  showLiveCourses = false;
                                  showPendingCourses = false;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_down_alt,
                                    color: showRejectedCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Rejected Courses',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color: showUploadCourses
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = false;
                                  showRejectedCourses = false;
                                  showUploadCourses = true;
                                  showLiveCourses = false;
                                  showPendingCourses = false;
                                  showDeleteCourses = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cloud_upload_rounded,
                                    color: showUploadCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Upload Courses',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            MaterialButton(
                              elevation: 0,
                              color: showDeleteCourses
                                  ? greenShadeColor
                                  : mainColor,
                              hoverColor: greenShadeColor,
                              padding: const EdgeInsets.all(20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showDashboardPanel = false;
                                  showApprovedCourses = false;
                                  showRejectedCourses = false;
                                  showUploadCourses = false;
                                  showLiveCourses = false;
                                  showPendingCourses = false;
                                  showDeleteCourses = true;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_rounded,
                                    color: showDeleteCourses
                                        ? greenSelectedColor
                                        : mainShadeColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Delete Courses',
                                    style: TextStyle(
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
                ],
              ),
            ),
            SizedBox(
              width: displayWidth(context) / 1.2,
              height: displayHeight(context),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: elevationColor,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(1, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              MaterialButton(
                                color: whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminDashBoard(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Admin Panel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              MaterialButton(
                                color: greenShadeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Course Panel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const TopBar(),
                      ],
                    ),
                  ),
                  showDeleteCourses ? const DeletedCourseScreen() : showRejectedCourses ? const RejectedCourseScreen() : showApprovedCourses ? const ApprovedCourseScreen() : showPendingCourses ? const UnApprovedCourseScreen() : showLiveCourses ? const LiveCourseScreen()  : const CoursePanelBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
