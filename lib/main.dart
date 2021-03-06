import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './widgets/new_transactions.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            ),
            button: TextStyle(
            color: Colors.white
            ),
          ),
        appBarTheme: const AppBarTheme(
           titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              ),
        )
      ),
      home: myHomePage(),
    );
  }
}

class myHomePage extends StatefulWidget{

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  @override
final List<Transaction> _userTransactions =[
    //  Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    } ).toList();
  }

  void _addNewTransaction(String txTitle , double txAmount, DateTime txDate){
    final newTx = Transaction(   //creating new object to Transaction
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString()
     );

     setState(() {
       _userTransactions.add(newTx);
     });
  }

  void _deletTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
        return NewTransactions(_addNewTransaction);
    },
    );
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }
  bool  _showChart = false;

  PreferredSizeWidget _buildAppBar(){
    return Platform.isIOS? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children:<Widget>[
        GestureDetector(
          onTap: ()=> _startAddNewTransaction(context), 
          child: Icon(CupertinoIcons.add))
          ],),
    ): AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
        IconButton(
          onPressed: ()=> _startAddNewTransaction(context), 
          icon: Icon(Icons.add))
          ],
      ) as PreferredSizeWidget;
  }

  Widget build(BuildContext context) {
    final mediaQuery =MediaQuery.of(context);
      final isLandscape =mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
      final txListWidget = Container(
          height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
          child: TransactionList(_userTransactions,_deletTransaction));

      final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         if (isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('Show chart', 
            style: Theme.of(context).textTheme.headline6,
            ),
            Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value:  _showChart, 
              onChanged: (val){
                setState(() {
                  _showChart= val;
                }); })
            ],),
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
      ],)
      ),);
    return Platform.isIOS? CupertinoPageScaffold(
      child: pageBody, 
      navigationBar: appBar as ObstructingPreferredSizeWidget
      , ) 
    : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container(): FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=> _startAddNewTransaction(context), 
          ),
    );
  }
}


        // TextButton(
        // child: Text('TextButton'),
        // style: TextButton.styleFrom(
        // primary: Colors.blue,
        // onSurface: Colors.grey,
        // ),
        // onPressed: ()=>{},
        // ),
        // ElevatedButton(
        // child: Text('ElevatedButton'),
        // style: TextButton.styleFrom(
        // primary: Colors.white,
        // backgroundColor: Colors.blue,
        // onSurface: Colors.grey,
        // ),
        // onPressed: ()=>{},
        // ),
        // OutlinedButton(
        // child: Text('OutlinedButton'),
        // style: TextButton.styleFrom(
        // primary: Colors.blue,
        // side: BorderSide(color: Colors.blue, width: 3),
        // onSurface: Colors.grey,
        // ),
        // onPressed: ()=>{},
        // ),