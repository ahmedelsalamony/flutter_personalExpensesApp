
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalexpensesapp/models/Transaction.dart';
import 'package:intl/intl.dart';
import 'package:personalexpensesapp/widgets/ChartBar.dart';

class Chart extends StatelessWidget{

  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
       final weekDay = DateTime.now().subtract(Duration(days: index));

       var totalSum = 0.0;
       for (var i = 0 ; i < recentTransactions.length;i++){
        if(recentTransactions[i].date.day == weekDay.day &&
           recentTransactions[i].date.month == weekDay.month &&
           recentTransactions[i].date.year == weekDay.year){
          totalSum += recentTransactions[i].amount;
        }
       }

      return{
      'day':DateFormat.E().format(weekDay),
      'amount':totalSum
      };
    });
  }


  double get weekTotalSum {
    return groupedTransactionValues.fold(0.0, (sum, element) {
       return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child:  ChartBar(data['day'],data['amount'],
                    weekTotalSum == 0.0 ? 0.0 : (data['amount'] as double) / weekTotalSum)
            );

          }).toList(),
        ),
      ),
    );
  }

}