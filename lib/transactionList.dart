// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  "No Transaaction",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal,
                  ),
                ),
              ),
              Image.asset(
                './images/car.jpg',
                fit: BoxFit.cover,
              )
            ],
          )
        : Column(
            children: transaction
                .map((e) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 5,
                        // margin: EdgeInsets.all(3),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.teal, width: 4),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 5),
                                child: Text(
                                  "\$ ${e.amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 0, 117, 105),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Text(
                                        DateFormat.yMMMd().format(e.time),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 156, 156, 156),
                                        ),
                                      ),
                                    ),
                                  ]),
                              IconButton(
                                  onPressed: () => deleteTransaction(e.id),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.teal,
                                  ))
                            ]),
                      ),
                    ))
                .toList(),
          );
  }
}
