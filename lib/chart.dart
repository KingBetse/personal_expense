import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import './transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].time.day == weekday.day &&
            recentTransaction[i].time.month == weekday.month &&
            recentTransaction[i].time.year == weekday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupValue.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupValue.map((e) {
          return Row(
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Chart_bar(
                    (e['day'] as String),
                    (e['amount'] as double),
                    totalSpending == 0
                        ? 00.00
                        : (e['amount'] as double) / totalSpending),
              ),
              // SizedBox(
              //   width: 5,
              // )
            ],
          );
        }).toList(),
      ),
    );
  }
}
