import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class AffiliateRankingScreen extends StatefulWidget {
  const AffiliateRankingScreen({super.key});

  @override
  State<AffiliateRankingScreen> createState() => _AffiliateRankingScreenState();
}

class _AffiliateRankingScreenState extends State<AffiliateRankingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
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
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/rank-badge.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1639932068331-c6518cb3b8db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
                            ),
                          ),
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
    );
  }
}
