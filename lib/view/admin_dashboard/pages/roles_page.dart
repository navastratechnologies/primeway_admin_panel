import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:primeway_admin_panel/view/helpers/helpers.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  bool showAllUsers = false;
  bool showApprovedUsers = false;
  bool showUnApprovedUsers = false;
  bool showRejectedUsers = false;
  bool showAddUserForm = false;
  bool editRole = false;

  String searchId = '';
  String userRole = 'super';
  String adminId = '';
  TextEditingController searchController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference admins =
      FirebaseFirestore.instance.collection('admins');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: displayWidth(context),
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
                        child: ExpansionTile(
                          backgroundColor: purpleColor,
                          collapsedBackgroundColor: purpleColor,
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Row(
                            children: [
                              Text(
                                'Add New User With Role',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Icon(
                                Icons.add_box_rounded,
                                color: whiteColor,
                                size: 40,
                              ),
                            ],
                          ),
                          children: [
                            addUsersForm(context),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          showAddUserForm = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: displayWidth(context),
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
                            Text(
                              'Add New User With Role',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.add_box_rounded,
                              color: whiteColor,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: Container(
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
                            hintText: 'Enter username to search',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              displayWidth(context) < 600 || displayWidth(context) < 1200
                  ? adminUsersList(context)
                  : Row(
                      children: [
                        addUsersForm(context),
                        const SizedBox(width: 50),
                        adminUsersList(context),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  addUsersForm(context) {
    return Padding(
      padding: displayWidth(context) > 400
          ? const EdgeInsets.all(30)
          : const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addUserFormTextField(
            'Enter name here',
            'Name',
            nameController,
          ),
          const SizedBox(height: 20),
          addUserFormTextField(
            'Enter username here',
            'Username',
            userNameController,
          ),
          const SizedBox(height: 20),
          addUserFormTextField(
            'Enter password here',
            'Password',
            passwordController,
          ),
          const SizedBox(height: 30),
          Text(
            'Select role here',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                userRole = 'super';
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: greenShadeColor,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: userRole == 'super' ? greenShadeColor : whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Super Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: displayWidth(context) < 600 ||
                          displayWidth(context) < 1200
                      ? displayWidth(context) / 2.5
                      : displayWidth(context) / 5,
                  child: Text(
                    '(Course upload + Campaigns Post options and delete options)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? whiteColor
                          : purpleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                userRole = 'sub';
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: greenShadeColor,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: userRole == 'sub' ? greenShadeColor : whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Sub Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: displayWidth(context) < 600 ||
                          displayWidth(context) < 1200
                      ? displayWidth(context) / 2.5
                      : displayWidth(context) / 5,
                  child: Text(
                    '(Course upload + Campaigns Post options)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: displayWidth(context) < 600 ||
                              displayWidth(context) < 1200
                          ? whiteColor
                          : purpleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            color: editRole ? purpleColor : greenShadeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            minWidth: 300,
            onPressed: editRole
                ? () {
                    if (userNameController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: mainColor,
                          content: Center(
                            child: Text(
                              'Please fill all the fields and select the role to continue',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      FirebaseFirestore.instance
                          .collection('admins')
                          .doc(adminId)
                          .update(
                        {
                          'name': nameController.text,
                          'username': userNameController.text,
                          'password': passwordController.text,
                          'role': userRole,
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: purpleColor,
                          content: Center(
                            child: Text(
                              'User data updated successfully and assigned $userRole admin role.',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        editRole = false;
                        userNameController.clear();
                        nameController.clear();
                        passwordController.clear();
                        userRole = 'super';
                      });
                    }
                  }
                : () {
                    if (userNameController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: mainColor,
                          content: Center(
                            child: Text(
                              'Please fill all the fields and select the role to continue',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      FirebaseFirestore.instance.collection('admins').add(
                        {
                          'name': nameController.text,
                          'username': userNameController.text,
                          'password': passwordController.text,
                          'role': userRole,
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: purpleColor,
                          content: Center(
                            child: Text(
                              'User added successfully and assigned $userRole admin role.',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        showAddUserForm = false;
                        userNameController.clear();
                        nameController.clear();
                        passwordController.clear();
                        userRole = 'super';
                      });
                    }
                  },
            child: Text(
              editRole ? 'Update User' : 'Add User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  adminUsersList(context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: greenShadeColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'All Users :-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                            hintText: 'Enter username to search',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: displayWidth(context) / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Center(
                            child: SelectableText(
                              "Name",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Center(
                            child: SelectableText(
                              "UserName",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Center(
                            child: SelectableText(
                              "Role Assigned",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Center(
                            child: SelectableText(
                              "Status",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Center(
                            child: SelectableText(
                              "Actions",
                              style: TextStyle(
                                color: whiteColor,
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
            height: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? null
                : displayHeight(context) / 1.85,
            width: displayWidth(context) < 600 || displayWidth(context) < 1200
                ? displayWidth(context)
                : displayWidth(context) / 2,
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: StreamBuilder(
              stream: admins.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: displayWidth(context) < 600 ||
                            displayWidth(context) < 1200
                        ? true
                        : false,
                    physics: displayWidth(context) < 600 ||
                            displayWidth(context) < 1200
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      if (documentSnapshot['username']
                          .toString()
                          .contains(searchId)) {
                        return displayWidth(context) < 600 ||
                                displayWidth(context) < 1200
                            ? Column(
                                children: [
                                  ExpansionTile(
                                    tilePadding: const EdgeInsets.all(6),
                                    title: SelectableText(
                                      documentSnapshot['username'],
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
                                      expansionTableData(
                                        'Name',
                                        documentSnapshot['name'],
                                        context,
                                      ),
                                      expansionTableData(
                                        'role',
                                        "${documentSnapshot['role']} admin",
                                        context,
                                      ),
                                      expansionTableData(
                                        'Status',
                                        documentSnapshot['status'],
                                        context,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: SizedBox(
                                          width: 120,
                                          child: MaterialButton(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            color: documentSnapshot['status'] ==
                                                    'banned'
                                                ? purpleColor
                                                : mainColor,
                                            onPressed: documentSnapshot[
                                                        'status'] ==
                                                    'banned'
                                                ? () {
                                                    admins
                                                        .doc(
                                                            documentSnapshot.id)
                                                        .update(
                                                      {
                                                        'status': 'active',
                                                      },
                                                    );
                                                  }
                                                : () {
                                                    admins
                                                        .doc(
                                                            documentSnapshot.id)
                                                        .update(
                                                      {
                                                        'status': 'banned',
                                                      },
                                                    );
                                                  },
                                            child: Text(
                                              documentSnapshot['status'] ==
                                                      'banned'
                                                  ? 'Unban Services'
                                                  : 'Ban Services',
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
                              )
                            : Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        documentSnapshot['name'] != null
                                            ? SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: SelectableText(
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: SelectableText(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        documentSnapshot['username'] != null
                                            ? SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: SelectableText(
                                                    documentSnapshot[
                                                        'username'],
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: SelectableText(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        documentSnapshot['role'] != null
                                            ? SizedBox(
                                                width: 140,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectableText(
                                                      "${documentSnapshot['role']} admin",
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      onPressed: () {
                                                        setState(() {
                                                          editRole = true;
                                                          nameController.text =
                                                              documentSnapshot[
                                                                  'name'];
                                                          userNameController
                                                                  .text =
                                                              documentSnapshot[
                                                                  'username'];
                                                          userRole =
                                                              documentSnapshot[
                                                                  'role'];
                                                          passwordController
                                                                  .text =
                                                              documentSnapshot[
                                                                  'password'];
                                                          adminId =
                                                              documentSnapshot
                                                                  .id;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit_note_rounded,
                                                        color: greenShadeColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: SelectableText(
                                                    '',
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                documentSnapshot['status'],
                                                style: TextStyle(
                                                  color: documentSnapshot[
                                                              'status'] ==
                                                          'active'
                                                      ? greenShadeColor
                                                      : mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: MaterialButton(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            color: documentSnapshot['status'] ==
                                                    'banned'
                                                ? purpleColor
                                                : mainColor,
                                            onPressed: documentSnapshot[
                                                        'status'] ==
                                                    'banned'
                                                ? () {
                                                    admins
                                                        .doc(
                                                            documentSnapshot.id)
                                                        .update(
                                                      {
                                                        'status': 'active',
                                                      },
                                                    );
                                                  }
                                                : () {
                                                    admins
                                                        .doc(
                                                            documentSnapshot.id)
                                                        .update(
                                                      {
                                                        'status': 'banned',
                                                      },
                                                    );
                                                  },
                                            child: Text(
                                              documentSnapshot['status'] ==
                                                      'banned'
                                                  ? 'Unban Services'
                                                  : 'Ban Services',
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
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
                      }
                      return null;
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  addUserFormTextField(hint, label, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
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
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
