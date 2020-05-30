import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:personalexpensesapp/widgets/NewTransaction.dart';
import 'package:personalexpensesapp/widgets/TransactionList.dart';
import 'models/Transaction.dart';
import 'widgets/Chart.dart';


void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
  //DeviceOrientation.portraitDown]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "personal expenses",
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().
          textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            button: TextStyle(color:Colors.white)
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  final List<Transaction> _transactionsList = [
   /* Transaction(id: "t1",title: "shoes",date: DateTime.now(),amount:98.9),
    Transaction(id: "t2",title: "jacket",date: DateTime.now(),amount:209.89)*/
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactionsList.where((tx) {
       return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
 }

  void _startAddNewTransaction(BuildContext context){
     showModalBottomSheet(context: context, builder: (bCtx){
       return GestureDetector(
         onTap: () {},
         child: NewTransaction(addNewTransaction),
         behavior: HitTestBehavior.opaque,
       );
    });
  }

  void addNewTransaction(String txTitle,double txAmount,DateTime selectedDate){
    final transaction = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString()
    );


    setState(() {
      _transactionsList.add(transaction);
    });
  }

  void deleteTransaction(String id){
    setState(() {
      _transactionsList.removeWhere((tx) =>  tx.id == id );
    });
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(

      middle: Text("personal expenses"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _startAddNewTransaction(context),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    ) : AppBar(
      title: Text("personal expenses",
        style: TextStyle(fontFamily: 'Quicksand',fontSize: 22),),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context) )
      ],
    );
    final txListwidget =
    Container(height:
    (mediaQuery.size.height - appBar.preferredSize.height -
        mediaQuery.padding.top) * 0.7 ,
        child: TransactionList(_transactionsList,deleteTransaction)
    );
    final pageBody = SafeArea(child: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            isLandscape ?
            Row(children: <Widget>[
              Text("show Chart?",style: Theme.of(context).textTheme.title),
              Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart, onChanged: (val){
                setState(() {
                  _showChart = val;
                });
              })
            ],
            ) : new Container(width: 0, height: 0) ,
            isLandscape ? // if landscape mode and user select show chart display charts only
            _showChart
                ?
            Container( height:
            (mediaQuery.size.height - appBar.preferredSize.height  - mediaQuery.padding.top) * 0.7
                ,child: Chart(_recentTransactions))
                : //else landscape mode and user select hide charts display list only
            txListwidget
                : // if portrait mode show charts and list
            Container( height:
            (mediaQuery.size.height - appBar.preferredSize.height  - mediaQuery.padding.top) * 0.4
                ,child: Chart(_recentTransactions)),
            txListwidget
            ,
          ],
        )
    ));


    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar) : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

            floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
                child: Icon(Icons.add),
                onPressed:
                    () => _startAddNewTransaction(context))
        );

  }
}
