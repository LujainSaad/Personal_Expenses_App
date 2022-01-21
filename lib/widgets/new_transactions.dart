import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController =  TextEditingController();
  DateTime? _selectedDate;


  void _submiData(){
    final enteredTitle = _titleController.text;
    final enteredAmount =double.parse(_amountController.text) ;
    if (_amountController.text.isEmpty) return;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null)
    return;

    widget.addTx(enteredTitle,enteredAmount,_selectedDate); 
    //widget let us use propteries outside state class 

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
       if (pickedDate == null) return;
       setState(() {
        _selectedDate = pickedDate;
      });
    });
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
                  controller: _titleController,
                  onSubmitted: (_)=> _submiData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_)=> _submiData(),
                ),
                Container(
                  height: 70,
                  child: Row( children: [
                    Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                    TextButton(
                     child: Text(
                       'Choose Date',
                       style: TextStyle(
                         color: Theme.of(context).primaryColor),
                       ),
                     onPressed: _presentDatePicker,
                   ),
                  ],),
                ),
                ElevatedButton(
                  onPressed: _submiData,
                   child: Text(
                     'Add Transaction',
                     style: TextStyle(color: Theme.of(context).textTheme.button!.color),
                     ),
                   style: TextButton.styleFrom(
                   backgroundColor: Theme.of(context).primaryColor, ),
                   ),
            ],
            ),
          ),
        );
  }
}