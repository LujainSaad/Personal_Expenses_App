import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController =  TextEditingController();

  void submiData(){
    final enteredTitle = titleController.text;
    final enteredAmount =double.parse(amountController.text) ;

    if (enteredTitle.isEmpty || enteredAmount <= 0)
    return;

    widget.addTx(enteredTitle,enteredAmount); 
    //widget let us use propteries outside state class 

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return        Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:<Widget> [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_)=> submiData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  onSubmitted: (_)=> submiData(),
                ),
                TextButton(
                  onPressed: submiData,
                   child: Text("Add Transaction"),
                   style: TextButton.styleFrom(
                   primary: Colors.purple ),
                   ),
            ],
            ),
          ),
        );
  }
}