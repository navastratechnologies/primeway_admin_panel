import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AffiliatePanelBody extends StatefulWidget {
  const AffiliatePanelBody({super.key});

  @override
  State<AffiliatePanelBody> createState() => _AffiliatePanelBodyState();
}

class _AffiliatePanelBodyState extends State<AffiliatePanelBody> {
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: ResponsiveGridList(
          minItemWidth: 400,
          children: [
            dashboardTile(
              'users',
              'All Affiliate Users',
              Icons.person_pin,
            ),
            dashboardTile(
              'courses',
              'Affiliate Courses',
              Icons.menu_book_rounded,
            ),
            dashboardTile(
              'Earnings',
              "Member's Earnings",
              Icons.currency_rupee_rounded,
            ),
            dashboardTile(
              'Earnings',
              "Top Rankers",
              Icons.military_tech_rounded,
            ),
            dashboardTile(
              'collaboration',
              "Total Collaborations",
              Icons.group_rounded,
            ),
            dashboardTile(
              'Earnings',
              "Total Refferals",
              Icons.share_rounded,
            ),
          ],
        ),
      ),
    );
  }

  dashboardTile(stream, title, icon) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        if (value) {
          setState(
            () {},
          );
        }
      },
      child: Container(
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
                      : FirebaseFirestore.instance
                          .collection(stream)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return SelectableText(
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
      ),
    );
  }
}
