import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showUsers = false;
  bool showTransactions = true;

  @override
  void initState() {
    super.initState();
  }

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
              InkWell(
                onTap: () {
                  setState(() {
                    showUsers = true;
                    showTransactions = false;
                  });
                },
                mouseCursor: SystemMouseCursors.click,
                child: dashboardTile(
                  '1000K',
                  'Total P Coins',
                  "Available In User's Wallet",
                  Icons.paid,
                  showUsers ? mainColor : greenShadeColor,
                  showUsers ? mainShadeColor : greenLightShadeColor,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    showUsers = false;
                    showTransactions = true;
                  });
                },
                mouseCursor: SystemMouseCursors.click,
                child: dashboardTile(
                  '100',
                  'Total Transactions',
                  "All Time Transactions",
                  Icons.point_of_sale,
                  showTransactions ? mainColor : greenShadeColor,
                  showTransactions ? mainShadeColor : greenLightShadeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
            child: showUsers
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: displayWidth(context) / 1.2,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: greenShadeColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Transactions :-',
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
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: SizedBox(
                              width: displayWidth(context) / 1.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        "User Id.",
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
                                        "UserName",
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
                                        "Wallet Balance",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Center(
                                      child: Text(
                                        "Action",
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
                            height: displayHeight(context) / 2.33,
                            width: displayWidth(context) / 1.2,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
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
                                                  '1000111',
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
                                                  'UserName',
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
                                                  '10K',
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 220,
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    MaterialButton(
                                                      color: greenShadeColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              height: 400,
                                                              color: whiteColor,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        MaterialButton(
                                                                      minWidth:
                                                                          0,
                                                                      height: 0,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              14),
                                                                      color:
                                                                          greenShadeColor,
                                                                      shape:
                                                                          const CircleBorder(),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color:
                                                                            whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  SizedBox(
                                                                    width: displayWidth(
                                                                            context) /
                                                                        3,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'User Id :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    '1000111',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Username :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    'Name Of The User',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Available Wallet Balance :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    '10K P Coins',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Add P Coin :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                Container(
                                                                                  width: 200,
                                                                                  height: 40,
                                                                                  alignment: Alignment.centerLeft,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    color: greenLightShadeColor,
                                                                                  ),
                                                                                  child: TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    decoration: const InputDecoration(
                                                                                      border: InputBorder.none,
                                                                                      isDense: true,
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: whiteColor,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        MaterialButton(
                                                                          color:
                                                                              greenShadeColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Text(
                                                                            'Add P Coins',
                                                                            style:
                                                                                TextStyle(
                                                                              color: whiteColor,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        'Add P Coins',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    MaterialButton(
                                                      color: mainColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              height: 400,
                                                              color: whiteColor,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        MaterialButton(
                                                                      minWidth:
                                                                          0,
                                                                      height: 0,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              14),
                                                                      color:
                                                                          greenShadeColor,
                                                                      shape:
                                                                          const CircleBorder(),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color:
                                                                            whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  SizedBox(
                                                                    width: displayWidth(
                                                                            context) /
                                                                        3,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'User Id :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    '1000111',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Username :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    'Name Of The User',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Available Wallet Balance :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: SelectableText(
                                                                                    '10K P Coins',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black.withOpacity(0.4),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 180,
                                                                                  child: Text(
                                                                                    'Deduct P Coin :',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 40),
                                                                                Container(
                                                                                  width: 200,
                                                                                  height: 40,
                                                                                  alignment: Alignment.centerLeft,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    color: mainShadeColor,
                                                                                  ),
                                                                                  child: TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    decoration: const InputDecoration(
                                                                                      border: InputBorder.none,
                                                                                      isDense: true,
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: whiteColor,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        MaterialButton(
                                                                          color:
                                                                              mainColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Text(
                                                                            'Deduct P Coins',
                                                                            style:
                                                                                TextStyle(
                                                                              color: whiteColor,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        'Deduct P Coins',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: displayWidth(context) / 1.2,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: greenShadeColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Transactions :-',
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
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: SizedBox(
                              width: displayWidth(context) / 1.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        "Trans. Id",
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
                                        "UserName",
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
                                        "Wallet Balance",
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
                                        "Withdrawal Req.",
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
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        "Action",
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
                            height: displayHeight(context) / 2.33,
                            width: displayWidth(context) / 1.2,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
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
                                                  '1000111',
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
                                                  'UserName',
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
                                                  '10K',
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
                                                  '3K',
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
                                                        ? greenShadeColor
                                                        : mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    index.isEven
                                                        ? "Approved"
                                                        : "Pending",
                                                    style: TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Center(
                                                child: index.isEven
                                                    ? null
                                                    : MaterialButton(
                                                        color: greenShadeColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        onPressed: () {
                                                          showModalBottomSheet<
                                                              void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                height: 400,
                                                                color:
                                                                    whiteColor,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(20),
                                                                child: Column(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          MaterialButton(
                                                                        minWidth:
                                                                            0,
                                                                        height:
                                                                            0,
                                                                        padding:
                                                                            const EdgeInsets.all(14),
                                                                        color:
                                                                            greenShadeColor,
                                                                        shape:
                                                                            const CircleBorder(),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    SizedBox(
                                                                      width:
                                                                          displayWidth(context) /
                                                                              3,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Transaction Id :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      '1000111',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Account Holder Name :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      'Name Of Account Holder',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Bank Name :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      'Centurus International Bank',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Account Number :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      '10001111000111',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'IFSC Code :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      'CENTU1234',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Available Wallet Balance :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      '10K',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 180,
                                                                                    child: Text(
                                                                                      'Withdrawl Request For :',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 40),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    child: SelectableText(
                                                                                      '3k',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Row(
                                                                            children: [
                                                                              MaterialButton(
                                                                                color: orange,
                                                                                onPressed: () {},
                                                                                child: Text(
                                                                                  'Accept Withdrawal Request',
                                                                                  style: TextStyle(
                                                                                    color: whiteColor,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 40),
                                                                              MaterialButton(
                                                                                color: yellow,
                                                                                onPressed: () {},
                                                                                child: Text(
                                                                                  'Mark Payment Done',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black.withOpacity(0.5),
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Text(
                                                          index.isEven
                                                              ? ""
                                                              : "Accept",
                                                          style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
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
        ],
      ),
    );
  }

  dashboardTile(count, title, subTitle, icon, color, iconColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: iconColor,
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
              SizedBox(
                width: displayWidth(context) / 3.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 50,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '/',
                      style: TextStyle(
                        fontSize: 50,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: whiteColor.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
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
              color: iconColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
