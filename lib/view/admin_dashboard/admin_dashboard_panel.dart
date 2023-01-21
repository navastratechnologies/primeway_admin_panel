import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/banner_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/collaboration_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/creator_programs_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/feedback_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/other_requests_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/user_page.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/wallet_page.dart';
import 'package:primeway_admin_panel/view/body_panels/admin_panel_body.dart';
import 'package:primeway_admin_panel/view/course_dashboard/course_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/top_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  bool showDashboardPanel = true;
  bool showUsersPanel = false;
  bool showWalletPanel = false;
  bool showBannerPanel = false;
  bool showCollaborationPanel = false;
  bool showCreatorProgramPanel = false;
  bool showFeedbackPanel = false;
  bool showOtherRequestPanel = false;
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
            ScreenTypeLayout(
              mobile: Container(),
              tablet: Container(
                width: 69,
                height: displayHeight(context),
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
              ),
              desktop: Container(
                width: displayWidth(context) / 6,
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
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
                                color: showUsersPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = true;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
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
                                      'Users',
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
                                color: showWalletPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = true;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.wallet,
                                      color: showWalletPanel
                                          ? greenSelectedColor
                                          : mainShadeColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Wallet',
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
                                color: showBannerPanel
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
                                    showBannerPanel = true;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.photo_library,
                                      color: showBannerPanel
                                          ? greenSelectedColor
                                          : mainShadeColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Banners',
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
                                color: showCollaborationPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = true;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.groups,
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
                                color: showCreatorProgramPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = true;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.design_services,
                                      color: showCreatorProgramPanel
                                          ? greenSelectedColor
                                          : mainShadeColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Creator Program Cat.',
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
                                color: showFeedbackPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = true;
                                    showOtherRequestPanel = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.question_answer_rounded,
                                      color: showFeedbackPanel
                                          ? greenSelectedColor
                                          : mainShadeColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'User Feedbacks',
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
                                color: showOtherRequestPanel
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
                                    showBannerPanel = false;
                                    showCollaborationPanel = false;
                                    showCreatorProgramPanel = false;
                                    showUsersPanel = false;
                                    showWalletPanel = false;
                                    showFeedbackPanel = false;
                                    showOtherRequestPanel = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.help_outline_rounded,
                                      color: showOtherRequestPanel
                                          ? greenSelectedColor
                                          : mainShadeColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Other Requests',
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
            ),
            ScreenTypeLayout(
              mobile: topBar(context, displayWidth(context)),
              tablet: topBar(context, displayWidth(context) / 1.1),
              desktop: topBar(context, displayWidth(context) / 1.2),
            ),
          ],
        ),
      ),
    );
  }

  topBar(BuildContext context, width) {
    return SizedBox(
      width: width,
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
                        color: greenShadeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Admin Panel',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      MaterialButton(
                        color: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CourseDashboard(),
                            ),
                          );
                        },
                        child: const Text(
                          'Course Panel',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
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
          showCreatorProgramPanel
              ? const CreatorProgramScreen()
              : showWalletPanel
                  ? const WalletScreen()
                  : showOtherRequestPanel
                      ? const OtherRequestScreen()
                      : showFeedbackPanel
                          ? const FeedBackScreen()
                          : showBannerPanel
                              ? const BannerScreen()
                              : showUsersPanel
                                  ? const UserScreen()
                                  : showCollaborationPanel
                                      ? const CollaborationScreen()
                                      : const AdminPanelBody(),
        ],
      ),
    );
  }
}
