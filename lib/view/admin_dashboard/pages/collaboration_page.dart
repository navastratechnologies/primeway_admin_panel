import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/pages/collabsuser.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'collaboration_detail.dart';
import 'collaboration_detail_edit.dart';

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
  final CollectionReference collaboration =
      FirebaseFirestore.instance.collection('collaboration');

  String searchId = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // getuploadedFilefirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) / 1.12,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveGridList(
                horizontalGridSpacing: 10,
                minItemWidth:
                    displayWidth(context) < 600 || displayWidth(context) < 1200
                        ? 200
                        : 350,
                listViewBuilderOptions: ListViewBuilderOptions(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                children: [
                  dashboardTile(
                    '100K',
                    'On-Going Collaborations',
                    Icons.groups,
                  ),
                  dashboardTile(
                    '120',
                    'Collaborations In Queue',
                    Icons.pending_actions_rounded,
                  ),
                  dashboardTile(
                    '10',
                    'Rejected Collaborations',
                    Icons.thumb_down_alt_rounded,
                  ),
                  dashboardTile(
                    '10',
                    'Users Participated In Collaborations',
                    Icons.person,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              displayWidth(context) < 600
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CollaborationDetailsScreen(),
                          ),
                        ),
                        child: Container(
                          width: displayWidth(context) / 1.1,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text(
                              'Add New Collaborations',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
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
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: greenShadeColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SelectableText(
                                      'Collaborations :-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        displayWidth(context) < 600
                                            ? Container()
                                            : searchField(),
                                        displayWidth(context) < 600
                                            ? Container()
                                            : const SizedBox(width: 10),
                                        displayWidth(context) < 600
                                            ? const SizedBox()
                                            : InkWell(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CollaborationDetailsScreen(),
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18),
                                                    child: Text(
                                                      'Add New Collaborations',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                displayWidth(context) < 600
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: searchField(),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              displayWidth(context) < 600 ||
                                      displayWidth(context) < 1200
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 5,
                                      ),
                                      child: SizedBox(
                                        // width: displayWidth(context) / 1.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: Center(
                                                child: SelectableText(
                                                  "Id",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Center(
                                                child: SelectableText(
                                                  "Brand logo",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Center(
                                                child: SelectableText(
                                                  "logo",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Center(
                                                child: SelectableText(
                                                  "Image",
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
                                                child: SelectableText(
                                                  "Collaboration Title",
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
                                                child: SelectableText(
                                                  "Required Followers",
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
                                                child: SelectableText(
                                                  "Language",
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
                                                child: SelectableText(
                                                  "Categories",
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
                                                child: SelectableText(
                                                  "Collaboration type",
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
                                                child: SelectableText(
                                                  "Collaboration type discription",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: Center(
                                                child: SelectableText(
                                                  "Discription",
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
                                                child: SelectableText(
                                                  "Additional requirements",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Center(
                                                child: SelectableText(
                                                  "Action",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              displayWidth(context) < 600 ||
                                      displayWidth(context) < 1200
                                  ? const SizedBox()
                                  : const Divider(),
                              SizedBox(
                                height: displayWidth(context) < 600 ||
                                        displayWidth(context) < 1200
                                    ? null
                                    : displayHeight(context) / 1.95,
                                child: StreamBuilder(
                                    stream: searchId.isEmpty
                                        ? collaboration.snapshots()
                                        : collaboration
                                            .where('id', isEqualTo: searchId)
                                            .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        return ListView.builder(
                                          shrinkWrap: displayWidth(context) <
                                                      600 ||
                                                  displayWidth(context) < 1200
                                              ? true
                                              : false,
                                          physics: displayWidth(context) <
                                                      600 ||
                                                  displayWidth(context) < 1200
                                              ? const NeverScrollableScrollPhysics()
                                              : const AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                              streamSnapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];
                                            return displayWidth(context) <
                                                        600 ||
                                                    displayWidth(context) < 1200
                                                ? Column(
                                                    children: [
                                                      ExpansionTile(
                                                        childrenPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        tilePadding:
                                                            const EdgeInsets
                                                                .all(6),
                                                        title: SelectableText(
                                                          documentSnapshot[
                                                              'id'],
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        children: [
                                                          expansionTableData(
                                                            'User Id',
                                                            documentSnapshot[
                                                                'id'],
                                                            context,
                                                          ),
                                                          expansionTableData(
                                                            'Name',
                                                            documentSnapshot[
                                                                'id'],
                                                            context,
                                                          ),
                                                          expansionTableData(
                                                            'Wallet Balance',
                                                            documentSnapshot[
                                                                'id'],
                                                            context,
                                                          ),
                                                          expansionTableData(
                                                            'Requested For',
                                                            documentSnapshot[
                                                                'id'],
                                                            context,
                                                          ),
                                                          expansionTableData(
                                                            'Status',
                                                            documentSnapshot[
                                                                'id'],
                                                            context,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 2),
                                                      const Divider(),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () =>
                                                              Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CollabUserScreen(
                                                                docId:
                                                                    documentSnapshot
                                                                        .id,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 80,
                                                                child: Center(
                                                                  child:
                                                                      SelectableText(
                                                                    documentSnapshot
                                                                        .id
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 80,
                                                                child: Center(
                                                                  child: Image
                                                                      .network(
                                                                    documentSnapshot[
                                                                        'image'],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 80,
                                                                child: Center(
                                                                  child: Image
                                                                      .network(
                                                                    documentSnapshot[
                                                                        'logo'],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 80,
                                                                child: Center(
                                                                  child: Image
                                                                      .network(
                                                                    documentSnapshot[
                                                                        'brand_logo'],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'titles'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        documentSnapshot[
                                                                            'required_followers_from'],
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.4),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "to",
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.4),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        documentSnapshot[
                                                                            'required_followers_to'],
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.4),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'language'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'categories'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'collaboration_type'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'collaboration_type_discription'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'descreption'],
                                                                  maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'additional_requirements'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                                child: InkWell(
                                                                  onTap: () =>
                                                                      Navigator
                                                                          .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CollaborationeditScreen(
                                                                        docId: documentSnapshot
                                                                            .id,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          greenShadeColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(),
                                                    ],
                                                  );
                                          },
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchField() {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchId = searchController.text;
          });
        },
        onEditingComplete: () {
          setState(() {
            searchId = searchController.text;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter collab id to search',
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  dashboardTile(status, title, icon) {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: status == "all-users"
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where('approval_status', isEqualTo: status)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return Text(
                        streamSnapshot.data!.docs.length.toString(),
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
              size: 120,
            ),
          ],
        ),
      ),
    );
  }
}
