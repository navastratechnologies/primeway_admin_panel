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
          rankHeading(Icons.military_tech_rounded, 'Daily Rankings'),
          SizedBox(
            height: 100,
            width: displayWidth(context),
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: displayWidth(context) / 4,
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
                        Row(
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
                                const Text(
                                  'First Ranker',
                                  style: TextStyle(
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          rankHeading(Icons.military_tech_rounded, 'Weekly Rankings'),
          rankHeading(Icons.military_tech_rounded, 'Monthly Rankings'),
          rankHeading(Icons.military_tech_rounded, 'Quaterly Rankings'),
          rankHeading(Icons.military_tech_rounded, 'Yearly Rankings'),
        ],
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
