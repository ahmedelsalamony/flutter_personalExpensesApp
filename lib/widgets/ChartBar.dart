import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ChartBar extends StatelessWidget{

  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (ctx,constrains){

      return Column(
        children: <Widget>[
          Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(child: Text('\$${spendingAmount.toString()}'))),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 10),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Text('${label}')
        ],
      );
    });

  }

}