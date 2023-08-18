import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/pages/affiliate_collaborations.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/pages/affiliate_courses.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/pages/affiliate_ranking_screen.dart';
import 'package:primeway_admin_panel/view/affiliate_dashboard/pages/affiliate_refferal_screen.dart';
import 'package:primeway_admin_panel/view/course_dashboard/course_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'pages/affiliate_earning.dart';
import 'pages/affiliate_users.dart';

class AffiliateDashboard extends StatefulWidget {
  const AffiliateDashboard({super.key});

  @override
  State<AffiliateDashboard> createState() => _AffiliateDashboardState();
}

class _AffiliateDashboardState extends State<AffiliateDashboard> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showDashboardPanel = true;
  bool showUsersPanel = false;
  bool showCoursesPanel = false;
  bool showEarningsPanel = false;
  bool showRankingsPanel = false;
  bool showCollaborationPanel = false;
  bool showReferralPanel = false;

  var data = {};
  String userCount = '';
  String coursesCount = '';
  String collaborationCount = '';

  String searchId = '';

  TextEditingController searchController = TextEditingController();

  final CollectionReference withDrawal =
      FirebaseFirestore.instance.collection('withdrawal_request');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: whiteColor,
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
                                            const CourseDashboard(),
                                      ),
                                    );
                                  },
                                  child: displayWidth(context) < 600
                                      ? const FaIcon(
                                          FontAwesomeIcons.book,
                                          color: Colors.black,
                                          size: 14,
                                        )
                                      : const Text(
                                          'Course Panel',
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
                                          FontAwesomeIcons.usersGear,
                                          color: whiteColor,
                                          size: 14,
                                        )
                                      : Text(
                                          'Affiliate Panel',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: whiteColor,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          // const TopBar(),
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
                    showRankingsPanel
                        ? const AffiliateRankingScreen()
                        : showCoursesPanel
                            ? const AffiliatePanelBodyCourses()
                            : showUsersPanel
                                ? const AffiliatePanelBodyUsers()
                                : showEarningsPanel
                                    ? const AffiliatePanelBodyEarnings()
                                    : showCollaborationPanel
                                        ? const AffiliateCollaborations()
                                        : showReferralPanel
                                            ? const AffiliateRefferalScreen()
                                            : Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30, bottom: 10),
                                                  child: ResponsiveGridList(
                                                    minItemWidth: 400,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                true;
                                                            showCoursesPanel =
                                                                false;
                                                            showEarningsPanel =
                                                                false;
                                                            showRankingsPanel =
                                                                false;
                                                            showCollaborationPanel =
                                                                false;
                                                            showReferralPanel =
                                                                false;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'users',
                                                          'All Affiliate Users',
                                                          Icons.person_pin,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                false;
                                                            showCoursesPanel =
                                                                true;
                                                            showEarningsPanel =
                                                                false;
                                                            showRankingsPanel =
                                                                false;
                                                            showCollaborationPanel =
                                                                false;
                                                            showReferralPanel =
                                                                false;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'courses',
                                                          'Affiliate Courses',
                                                          Icons
                                                              .menu_book_rounded,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                false;
                                                            showCoursesPanel =
                                                                false;
                                                            showEarningsPanel =
                                                                true;
                                                            showRankingsPanel =
                                                                false;
                                                            showCollaborationPanel =
                                                                false;
                                                            showReferralPanel =
                                                                false;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'Earnings',
                                                          "Member's Earnings",
                                                          Icons
                                                              .currency_rupee_rounded,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                false;
                                                            showCoursesPanel =
                                                                false;
                                                            showEarningsPanel =
                                                                false;
                                                            showRankingsPanel =
                                                                true;
                                                            showCollaborationPanel =
                                                                false;
                                                            showReferralPanel =
                                                                false;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'Earnings',
                                                          "Top Rankers",
                                                          Icons
                                                              .military_tech_rounded,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                false;
                                                            showCoursesPanel =
                                                                false;
                                                            showEarningsPanel =
                                                                false;
                                                            showRankingsPanel =
                                                                false;
                                                            showCollaborationPanel =
                                                                true;
                                                            showReferralPanel =
                                                                false;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'collaboration',
                                                          "Total Collaborations",
                                                          Icons.group_rounded,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDashboardPanel =
                                                                false;
                                                            showUsersPanel =
                                                                false;
                                                            showCoursesPanel =
                                                                false;
                                                            showEarningsPanel =
                                                                false;
                                                            showRankingsPanel =
                                                                false;
                                                            showCollaborationPanel =
                                                                false;
                                                            showReferralPanel =
                                                                true;
                                                          });
                                                        },
                                                        child: dashboardTile(
                                                          'Earnings',
                                                          "Total Refferals",
                                                          Icons.share_rounded,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(left: 6),
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
                        showUsersPanel = false;
                        showCoursesPanel = false;
                        showEarningsPanel = false;
                        showRankingsPanel = false;
                        showCollaborationPanel = false;
                        showReferralPanel = false;
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
                    color: showUsersPanel ? greenShadeColor : mainColor,
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
                        showUsersPanel = true;
                        showCoursesPanel = false;
                        showEarningsPanel = false;
                        showRankingsPanel = false;
                        showCollaborationPanel = false;
                        showReferralPanel = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: showUsersPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Affiliate Users',
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
                    color: showCoursesPanel ? greenShadeColor : mainColor,
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
                        showUsersPanel = false;
                        showCoursesPanel = true;
                        showEarningsPanel = false;
                        showRankingsPanel = false;
                        showCollaborationPanel = false;
                        showReferralPanel = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.book_rounded,
                          color: showCoursesPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Affiliate Courses',
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
                    color: showEarningsPanel ? greenShadeColor : mainColor,
                    hoverColor: greenShadeColor,
                    padding: const EdgeInsets.all(20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (displayWidth(context) < 1200) {
                            Navigator.pop(context);
                          }
                          showDashboardPanel = false;
                          showUsersPanel = false;
                          showCoursesPanel = false;
                          showEarningsPanel = true;
                          showRankingsPanel = false;
                          showCollaborationPanel = false;
                          showReferralPanel = false;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_rounded,
                          color: showEarningsPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Affiliate Earnings',
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
                    color: showRankingsPanel ? greenShadeColor : mainColor,
                    hoverColor: greenShadeColor,
                    padding: const EdgeInsets.all(20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (displayWidth(context) < 1200) {
                            Navigator.pop(context);
                          }
                          showDashboardPanel = false;
                          showUsersPanel = false;
                          showCoursesPanel = false;
                          showEarningsPanel = false;
                          showRankingsPanel = true;
                          showCollaborationPanel = false;
                          showReferralPanel = false;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.military_tech_rounded,
                          color: showRankingsPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Affiliate Rankings',
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
                    color: showCollaborationPanel ? greenShadeColor : mainColor,
                    hoverColor: greenShadeColor,
                    padding: const EdgeInsets.all(20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (displayWidth(context) < 1200) {
                            Navigator.pop(context);
                          }
                          showDashboardPanel = false;
                          showUsersPanel = false;
                          showCoursesPanel = false;
                          showEarningsPanel = false;
                          showRankingsPanel = false;
                          showCollaborationPanel = true;
                          showReferralPanel = false;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.group_rounded,
                          color: showCollaborationPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Collaborations',
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
                    color: showReferralPanel ? greenShadeColor : mainColor,
                    hoverColor: greenShadeColor,
                    padding: const EdgeInsets.all(20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (displayWidth(context) < 1200) {
                            Navigator.pop(context);
                          }
                          showDashboardPanel = false;
                          showUsersPanel = false;
                          showCoursesPanel = false;
                          showEarningsPanel = false;
                          showRankingsPanel = false;
                          showCollaborationPanel = false;
                          showReferralPanel = true;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.share_rounded,
                          color: showReferralPanel
                              ? greenSelectedColor
                              : mainShadeColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Refferals',
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

  dashboardTile(stream, title, icon) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                stream: stream == 'affilate_dashboard'
                    ? FirebaseFirestore.instance
                        .collection(stream)
                        .doc('NkcdMPSuI3SSIpJ2uLuv')
                        .collection('affiliate_users')
                        .snapshots()
                    : FirebaseFirestore.instance.collection(stream).snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Text(
                      title == 'Top Rankers'
                          ? '3'
                          : streamSnapshot.data!.docs.length.toString(),
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
            size: displayWidth(context) < 1200 ? 80 : 120,
          ),
        ],
      ),
    );
  }
}
