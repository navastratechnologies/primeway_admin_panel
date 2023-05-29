import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/affiliate_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/body_panels/course_panel_body.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/approved_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/comboscreen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courses2.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/delete_combo.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/deleted_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/live_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/rejected_course_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/unapproved_course_screen.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

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
  bool showCombo = false;
  bool showdeletecombo = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Drawer(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: sideBar(context),
          ),
        ),
      ),
      body: SizedBox(
        width: displayWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            displayWidth(context) < 1200
                ? const SizedBox()
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                      child: sideBar(context),
                    ),
                  ),
            Expanded(
              flex: displayWidth(context) > 1200 ? 7 : 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
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
                                  minWidth: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                  child: displayWidth(context) < 600
                                      ? const FaIcon(
                                          FontAwesomeIcons.userGear,
                                          color: Colors.black,
                                          size: 14,
                                        )
                                      : const Text(
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
                                  minWidth: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {},
                                  child: displayWidth(context) < 600
                                      ? FaIcon(
                                          FontAwesomeIcons.book,
                                          color: whiteColor,
                                          size: 14,
                                        )
                                      : Text(
                                          'Course Panel',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: whiteColor,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 16),
                                MaterialButton(
                                  color: whiteColor,
                                  minWidth: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AffiliateDashboard(),
                                      ),
                                    );
                                  },
                                  child: displayWidth(context) < 600
                                      ? const FaIcon(
                                          FontAwesomeIcons.usersGear,
                                          color: Colors.black,
                                          size: 14,
                                        )
                                      : const Text(
                                          'Affiliate Panel',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: displayWidth(context) > 1200
                                ? () {}
                                : () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                            child: FaIcon(
                              FontAwesomeIcons.bars,
                              color: greenShadeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    showDeleteCourses
                        ? const DeletedCourseScreen()
                        : showUploadCourses
                            ? const CoursesPage()
                            : showRejectedCourses
                                ? const RejectedCourseScreen()
                                : showApprovedCourses
                                    ? const ApprovedCourseScreen()
                                    : showPendingCourses
                                        ? const UnApprovedCourseScreen()
                                        : showLiveCourses
                                            ? const LiveCourseScreen()
                                            : showCombo
                                                ? const ComboPage()
                                                : showdeletecombo
                                                    ? const DeletedComboScreen()
                                                    : const CoursePanelBody(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sideBar(BuildContext context) {
    return Container(
      height: displayHeight(context),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: elevationColor,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
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
                              fontSize: 26,
                            ),
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
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    elevation: 0,
                    color: showDashboardPanel ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = true;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showLiveCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = true;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showPendingCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = true;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showApprovedCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = true;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showRejectedCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = true;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showUploadCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = true;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = false;
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
                    color: showCombo ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = true;
                        showdeletecombo = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.data_object,
                          color:
                              showCombo ? greenSelectedColor : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Combos',
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
                    color: showDeleteCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = true;
                        showCombo = false;
                        showdeletecombo = false;
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
                  const SizedBox(height: 6),
                  MaterialButton(
                    elevation: 0,
                    color: showDeleteCourses ? greenShadeColor : mainColor,
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
                        if (displayWidth(context) < 1200) {
                          Navigator.pop(context);
                        }
                        showDashboardPanel = false;
                        showApprovedCourses = false;
                        showRejectedCourses = false;
                        showUploadCourses = false;
                        showLiveCourses = false;
                        showPendingCourses = false;
                        showDeleteCourses = false;
                        showCombo = false;
                        showdeletecombo = true;
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
                          'Delete Combos',
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
      ),
    );
  }
}
