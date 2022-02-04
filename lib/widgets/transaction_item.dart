import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_experience_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deletTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deletTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Container(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
         ),
          title: Text(
           transaction.title,
           style: Theme.of(context).textTheme.headline6,
           ),
           subtitle:Text(
                 DateFormat.yMMMd().format(transaction.date),
                 ),
           trailing: MediaQuery.of(context).size.width>450?
           TextButton.icon(
             icon:Icon(Icons.delete),
             label:Text('Delete'),
             style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).errorColor)),
             onPressed: ()=> deletTx(transaction.id), 
           ):
           IconButton(
             onPressed: ()=> deletTx(transaction.id), 
             icon: Icon(Icons.delete),
             color: Theme.of(context).errorColor, //we can change it from themes
             ),
         ),
    );
  }
}