import 'package:flutter/material.dart';

class Chart_bar extends StatelessWidget {
  final String lable;
  final double sMoney;
  final double pCtotal;

  Chart_bar(this.lable, this.sMoney, this.pCtotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text("\$${sMoney.toStringAsFixed(0)}"))),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.60,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromARGB(255, 220, 213, 213),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                    heightFactor: pCtotal,
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromARGB(255, 0, 198, 178),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text("${lable}"))),
        ],
      );
    });
  }
}
