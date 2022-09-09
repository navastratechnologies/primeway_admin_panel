import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/components/body_panels/admin_panel_body.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/components/side_bars/admin_side_bar.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/components/top_bar.dart';
import 'package:primeway_admin_panel/view/course_dashboard/course_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
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
            const AdminSideBar(),
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
                  const AdminPanelBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
