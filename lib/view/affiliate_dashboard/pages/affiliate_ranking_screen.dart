import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AffiliateRankingScreen extends StatefulWidget {
  const AffiliateRankingScreen({super.key});

  @override
  State<AffiliateRankingScreen> createState() => _AffiliateRankingScreenState();
}

class _AffiliateRankingScreenState extends State<AffiliateRankingScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              rankHeading(Icons.military_tech_rounded, 'Daily Rankings'),
              dataList('today_earning'),
              rankHeading(Icons.military_tech_rounded, 'Weekly Rankings'),
              dataList('weekly_earning'),
              rankHeading(Icons.military_tech_rounded, 'Monthly Rankings'),
              dataList('monthly_earning'),
              rankHeading(Icons.military_tech_rounded, 'Quaterly Rankings'),
              dataList('quaterly_earning'),
              rankHeading(Icons.military_tech_rounded, 'Yearly Rankings'),
              dataList('annualy_earning'),
            ],
          ),
        ),
      ),
    );
  }

  dataList(field) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('affilate_dashboard')
          .doc('NkcdMPSuI3SSIpJ2uLuv')
          .collection('affiliate_users')
          .orderBy(field, descending: true)
          .limit(3)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return dailyRankingList(snapshot);
        }
        return Container();
      },
    );
  }

  dailyRankingList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return ResponsiveGridList(
      horizontalGridSpacing: 10,
      minItemWidth: displayWidth(context) < 600
          ? displayWidth(context)
          : displayWidth(context) < 1200
              ? displayWidth(context) / 3
              : displayWidth(context) / 4,
      listViewBuilderOptions: ListViewBuilderOptions(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
      children: List.generate(
        snapshot.data!.docs.length,
        (index) {
          DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? greenShadeColor.withOpacity(0.1)
                                    : index == 1
                                        ? purpleColor.withOpacity(0.1)
                                        : mainColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Text(
                                "#${index + 1}",
                                style: TextStyle(
                                  color: index == 0
                                      ? greenShadeColor
                                      : index == 1
                                          ? purpleColor
                                          : mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              index == 0
                                  ? 'First Ranker'
                                  : index == 1
                                      ? 'Second Ranker'
                                      : 'Third Ranker',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          index == 0
                              ? 'assets/first-rank.png'
                              : index == 1
                                  ? 'assets/second-rank.png'
                                  : 'assets/third-rank.png',
                          fit: BoxFit.contain,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('user_Id', isEqualTo: documentSnapshot.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          for (var i = 0; i < snapshot.data!.docs.length;) {
                            DocumentSnapshot userDocSnapshot =
                                snapshot.data!.docs[i];
                            return Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          userDocSnapshot['profile_pic'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: userDocSnapshot['profile_pic'] ==
                                                null ||
                                            userDocSnapshot['profile_pic'] ==
                                                '' ||
                                            userDocSnapshot['profile_pic']
                                                .toString()
                                                .isEmpty
                                        ? Text(
                                            "#${index + 1}",
                                            style: TextStyle(
                                              color: index == 0
                                                  ? greenShadeColor
                                                  : index == 1
                                                      ? purpleColor
                                                      : mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userDocSnapshot['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Lottie.asset(
                                            userDocSnapshot['youtube_username'] ==
                                                        '' ||
                                                    userDocSnapshot[
                                                            'youtube_username'] ==
                                                        null ||
                                                    userDocSnapshot[
                                                            'youtube_username']
                                                        .toString()
                                                        .isEmpty
                                                ? 'assets/json/instagram-icon.json'
                                                : 'assets/json/youtube.json',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            reverse: true,
                                          ),
                                          Text(
                                            userDocSnapshot['youtube_username'] ==
                                                        '' ||
                                                    userDocSnapshot[
                                                            'youtube_username'] ==
                                                        null ||
                                                    userDocSnapshot['youtube_username']
                                                        .toString()
                                                        .isEmpty
                                                ? userDocSnapshot[
                                                    'instagram_username']
                                                : userDocSnapshot[
                                                    'youtube_username'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return Container();
                      }),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot['courseShared'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == 0
                                    ? greenShadeColor
                                    : index == 1
                                        ? purpleColor
                                        : mainColor,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Courses Shared',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 2,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot['totalRefferals'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == 0
                                    ? greenShadeColor
                                    : index == 1
                                        ? purpleColor
                                        : mainColor,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Refferals',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 2,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot['today_earning'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == 0
                                    ? greenShadeColor
                                    : index == 1
                                        ? purpleColor
                                        : mainColor,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Today's Earning",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3),
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
          );
        },
      ),
    );
  }

  rankHeading(icon, heading) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: whiteColor,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            heading,
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
