// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime? sDate = null;
  final amountController = TextEditingController();

  void handleSub() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) < 0 ||
        sDate == null) {
      return;
    }

    widget.addTransaction(
        titleController.text, double.parse(amountController.text), sDate);
    Navigator.of(context).pop();
  }

  void selectedDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      sDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (value) => handleSub(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (value) => handleSub(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(sDate == null
                        ? "No Date Selected"
                        : "Date Picked: ${DateFormat.yMMMd().format(sDate!)} "),
                    TextButton(
                        onPressed: selectedDate,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: ElevatedButton(
                    onPressed: handleSub,
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
