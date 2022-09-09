import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class AdminSideBar extends StatefulWidget {
  const AdminSideBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminSideBar> createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {
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
    return Container(
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
                      color: showDashboardPanel? greenShadeColor : mainColor,
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
                            color: showDashboardPanel ? greenSelectedColor : mainShadeColor,
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
                            color: showUsersPanel ? greenSelectedColor : mainShadeColor,
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
                      color: showWalletPanel ? greenShadeColor : mainColor,
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
                            color: showWalletPanel ? greenSelectedColor : mainShadeColor,
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
                      color: showBannerPanel ? greenShadeColor : mainColor,
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
                            color: showBannerPanel ? greenSelectedColor : mainShadeColor,
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
                            color: showCollaborationPanel ? greenSelectedColor : mainShadeColor,
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
                      color: showCreatorProgramPanel ? greenShadeColor : mainColor,
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
                            color: showCreatorProgramPanel ? greenSelectedColor : mainShadeColor,
                          ),
                         const SizedBox(width: 10),
                          Text(
                            'Creator Programs',
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
                      color: showFeedbackPanel ? greenShadeColor : mainColor,
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
                            color: showFeedbackPanel ? greenSelectedColor : mainShadeColor,
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
                      color: showOtherRequestPanel ? greenShadeColor : mainColor,
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
                            color: showOtherRequestPanel ? greenSelectedColor : mainShadeColor,
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
    );
  }
}
