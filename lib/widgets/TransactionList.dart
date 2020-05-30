
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpensesapp/models/Transaction.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList( this.transactions,this.deletetx);

  @override
  Widget build(BuildContext context) {
     return  transactions.isEmpty ?
   LayoutBuilder(builder : (ctx,constrains) {
                 return Column(
                     children: <Widget>[
                       Text("no transactions yet !!"),
                       Container(
                           height: constrains.maxHeight * 0.4,
                           child: Image.asset('assets/images/Money.png'))
                     ],
                 );
               })
         : ListView.builder( itemBuilder: (ctx,index){
         return Card(
           elevation: 5,
             margin: EdgeInsets.symmetric(vertical: 10,
             horizontal: 10),
           child: ListTile(
             leading: CircleAvatar(
               radius: 30,
               child: Padding(
                 padding: EdgeInsets.all(8.0),
                 child:FittedBox(child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),)
               ),
             ),
             title: Text(transactions[index].title,
                 style: Theme.of(context).textTheme.title),
             subtitle: Text(DateFormat().format(transactions[index].date),
           ),
             trailing: MediaQuery.of(context).size.width > 340 ? FlatButton.icon(
                 icon: Icon(Icons.delete),
                 textColor : Theme.of(context).errorColor,
                 onPressed: () => deletetx(transactions[index].id)
             ) : IconButton(icon: Icon(Icons.delete),
             color: Theme.of(context).errorColor,
             onPressed: () => deletetx(transactions[index].id),),
         )
         );

         },
         itemCount: transactions.length,
       );
  }}