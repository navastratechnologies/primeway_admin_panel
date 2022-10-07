import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class CollaborationScreen extends StatefulWidget {
  const CollaborationScreen({super.key});

  @override
  State<CollaborationScreen> createState() => _CollaborationScreenState();
}

class _CollaborationScreenState extends State<CollaborationScreen> {
  bool showAllUsers = false;
  bool showApprovedUsers = false;
  bool showUnApprovedUsers = false;
  bool showRejectedUsers = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardTile(
                '100K',
                'On-Going Collaborations',
                Icons.groups,
              ),
              const SizedBox(width: 20),
              dashboardTile(
                '120',
                'Collaborations In Queue',
                Icons.pending_actions_rounded,
              ),
              const SizedBox(width: 20),
              dashboardTile(
                '10',
                'Rejected Collaborations',
                Icons.thumb_down_alt_rounded,
              ),
              const SizedBox(width: 20),
              dashboardTile(
                '10',
                'Users Participated In Collaborations',
                Icons.person,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: elevationColor,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: displayWidth(context) / 2,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: greenShadeColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Collaborations :-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            width: displayWidth(context) / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      "Id",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      "Collaboration",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      "Participated Users",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: displayHeight(context) / 2.3,
                          width: displayWidth(context) / 2,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Center(
                                              child: Text(
                                                "${index.toString()}. ",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                "ABC Company Promotion",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                "1K",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: index.isEven
                                                      ? greenLightShadeColor
                                                      : mainShadeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  index.isEven
                                                      ? "Approved"
                                                      : "Pending",
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: displayWidth(context) / 4,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_rounded,
                      size: 110,
                      color: greenLightShadeColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add New Collaborations',
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
        ],
      ),
    );
  }

  dashboardTile(count, title, icon) {
    return Container(
      padding: const EdgeInsets.all(5),
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 50,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 135,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Icon(
              icon,
              color: greenLightShadeColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
