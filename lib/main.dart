import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';
// import 'package:flutter/services.dart';
// import 'package:personal_expenses/widgets/user_transaction.dart';

import 'models/transactions.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demois',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        errorColor: Colors.indigo,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
          button: TextStyle(
            color: Colors.white
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title
  }): super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State < MyHomePage > {
  final List < Transaction > transaction = [
    Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Weekly Groceries', amount: 90.99, date: DateTime.now())
  ];

  List < Transaction > get recentTransaction {
    return transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(title: title, amount: amount, date: date,
      id: DateTime.now().toString());

    setState(() {
      transaction.add(newTx);
    });
  }


  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (bCtx) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction));
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: < Widget > [
        IconButton(icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context)),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: < Widget > [
            Row(children: <Widget>[
              Text('Show Chart'),
              Switch(
                value: showChart,
                onChanged: (val){
                    setState(() {
                      showChart = val;
                    });
                },
              )
            ],),
            showChart ? Container(child: Chart(recentTransaction),
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) * 0.3, ):
            Container(child: TransactionList(transaction, deleteTransaction),
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) * 0.7)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}