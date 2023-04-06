import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsChart extends StatefulWidget {
  @override
  _TransactionsChartState createState() => _TransactionsChartState();
}

class _TransactionsChartState extends State<TransactionsChart> {
  List<TransactionData> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('transactions').get();
    List<TransactionData> transactions = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return TransactionData(
        userId: data['userId'],
        userName: data['userName'],
        transactionId: data['transactionId'],
        walletBalance: data['walletBalance'].toDouble(),
        requestedFor: data['requestedFor'],
        status: data['status'],
      );
    }).toList();
    setState(() {
      _transactions = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TransactionData, String>> seriesList = [
      charts.Series(
        id: 'Transactions',
        data: _transactions,
        domainFn: (TransactionData transaction, _) => transaction.userName,
        measureFn: (TransactionData transaction, _) =>
            transaction.walletBalance,
        colorFn: (TransactionData transaction, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
    ];

    return SizedBox(
      height: 300,
      child: charts.BarChart(
        seriesList,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          charts.ChartTitle('Transactions by User',
              behaviorPosition: charts.BehaviorPosition.top),
          charts.SeriesLegend(),
        ],
      ),
    );
  }
}

class TransactionData {
  final String userId;
  final String userName;
  final String transactionId;
  final double walletBalance;
  final String requestedFor;
  final String status;

  TransactionData({
    required this.userId,
    required this.userName,
    required this.transactionId,
    required this.walletBalance,
    required this.requestedFor,
    required this.status,
  });
}
