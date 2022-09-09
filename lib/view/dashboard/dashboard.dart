import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/dashboard/components/body_panels/admin_panel_body.dart';
import 'package:primeway_admin_panel/view/dashboard/components/body_panels/course_panel_body.dart';
import 'package:primeway_admin_panel/view/dashboard/components/side_bars/admin_side_bar.dart';
import 'package:primeway_admin_panel/view/dashboard/components/side_bars/course_side_bar.dart';
import 'package:primeway_admin_panel/view/dashboard/components/top_bar.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool showAdminPanel = true;
  bool showCoursePanel = false;

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
            showAdminPanel ? const AdminSideBar() : const CourseSideBar(),
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
                                color: showAdminPanel
                                    ? greenShadeColor
                                    : whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showAdminPanel = true;
                                    showCoursePanel = false;
                                  });
                                },
                                child: Text(
                                  'Admin Panel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: showAdminPanel
                                        ? whiteColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              MaterialButton(
                                color: showCoursePanel
                                    ? greenShadeColor
                                    : whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showAdminPanel = false;
                                    showCoursePanel = true;
                                  });
                                },
                                child: Text(
                                  'Course Panel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: showCoursePanel
                                        ? whiteColor
                                        : Colors.black,
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
                  showAdminPanel ? const AdminPanelBody() : const CoursePanelBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
