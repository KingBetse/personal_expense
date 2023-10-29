// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:personal_expense/chart.dart';

import './new_transaction.dart';
import './transactionList.dart';
import './transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: "Poppins"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// ignore: deprecated_colon_for_default_value

  final List<Transaction> transaction = [];
  List<Transaction> get recentTransaction {
    return transaction.where((tx) {
      return tx.time.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void addTransaction(String txTitle, double txAmount, DateTime sDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        time: sDate);
    setState(() {
      transaction.add(newTx);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      transaction.removeWhere((element) => element.id == id);
    });
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expense',
        style: TextStyle(fontFamily: "Poppins"),
      ),
      actions: [
        IconButton(
            onPressed: () => startNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text("Show Chart"),
              // Switch(
              //     value: showChart,
              //     onChanged: (val) {
              //       setState(() {
              //         showChart = val;
              //       });
              //     }),
              // showChart == true
              //     ?
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: Chart(recentTransaction),
              ),
              // : SizedBox(
              //     height: 0,
              //   ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.8,
                child: TransactionList(transaction, deleteTransaction),
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
