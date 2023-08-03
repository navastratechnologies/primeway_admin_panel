import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:primeway_admin_panel/view/admin_dashboard/admin_dashboard_panel.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final box = GetStorage();

  bool showWarning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: displayHeight(context),
            width: displayWidth(context),
            decoration: const BoxDecoration(
              color: Color(0xff1C1B2B),
            ),
            child: Lottie.asset(
              'assets/json/background_animation.json',
              reverse: true,
            ),
          ),
          displayWidth(context) > 700
              ? Center(
                  child: Container(
                    height: displayHeight(context) / 1.3,
                    width: displayWidth(context) / 1.5,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(40),
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
                        leftSideView(context),
                        displayWidth(context) > 1200
                            ? rightSideView()
                            : Container(),
                      ],
                    ),
                  ),
                )
              : leftSideView(context),
        ],
      ),
    );
  }

  leftSideView(context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Stack(
          children: [
            Container(
              height: displayWidth(context) > 700
                  ? displayHeight(context) / 1.3
                  : displayHeight(context),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Lottie.asset(
                'assets/json/background_spiral.json',
                fit: BoxFit.cover,
                reverse: true,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: displayWidth(context) > 1800
                        ? displayWidth(context) / 6
                        : displayWidth(context) > 1200
                            ? displayWidth(context) / 5
                            : displayWidth(context) > 700
                                ? displayWidth(context) / 2.5
                                : displayWidth(context) / 1.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        displayWidth(context) > 1200
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/primeway-logo.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Primewayskills Private Limited',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Influencers Branding & Marketting Platform',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 4,
                              height: 55,
                              decoration: BoxDecoration(
                                color: greenLightShadeColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                  ),
                                ),
                                Text(
                                  'Welcome back! Please enter your details',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        loginField(
                          ' Username',
                          usernameController,
                          'Enter username',
                        ),
                        const SizedBox(height: 20),
                        loginField(
                          ' Password',
                          passwordController,
                          'Enter password',
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                color: greenLightShadeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            minWidth: 280,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(20),
                            color: greenLightShadeColor,
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('admins')
                                  .where('username',
                                      isEqualTo: usernameController.text)
                                  .where('password',
                                      isEqualTo: passwordController.text)
                                  .get()
                                  .then(
                                (value) {
                                  if (value.docs.isNotEmpty) {
                                    storeTokenAndDataForWeb(
                                        usernameController.text);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminDashBoard(),
                                      ),
                                    );
                                  } else {
                                    setState(
                                      () {
                                        usernameController.clear();
                                        passwordController.clear();
                                        showWarning = true;
                                        Timer(
                                          const Duration(seconds: 2),
                                          () {
                                            setState(
                                              () {
                                                showWarning = false;
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        showWarning
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Text(
                                  'username or password is incorrect. Please login with right credentials',
                                  style: GoogleFonts.poppins(
                                    color: mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Container(),
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

  rightSideView() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffF3F4F8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/primeway-logo.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 10),
              Text(
                'Primewayskills Private Limited',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Text(
                'Influencers Branding & Marketting Platform',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void storeTokenAndDataForWeb(username) async {
    box.write('username', username);
  }

  loginField(heading, controller, hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            // fontSize: 26,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
