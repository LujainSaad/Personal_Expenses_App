import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions ;
  Function deletTx;

  TransactionList(this.transactions,this.deletTx);

  @override
  Widget build(BuildContext context) {
    return Container (
           height: 600,
           child: transactions.isEmpty? 
            LayoutBuilder(
              builder: (ctx, constraints) {
               return Column(children: [
                 Text( 'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('image/waiting.png',
                    fit: BoxFit.cover ),
                  )
           ],);
           })
            : ListView.builder(
             itemBuilder: (ctx, index) {
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
                       child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),
                     ),
                   ),
                  ),
                   title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle:Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          ),
                    trailing: MediaQuery.of(context).size.width>450?
                    TextButton.icon(
                      icon:Icon(Icons.delete),
                      label:Text('Delete'),
                      style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).errorColor)),
                      onPressed: ()=> deletTx(transactions[index].id), 
                    ):
                    IconButton(
                      onPressed: ()=> deletTx(transactions[index].id), 
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor, //we can change it from themes
                      ),
                  ),
             );  },
        itemCount: transactions.length,
      ),
    );
  }
}

//                Card(
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      margin: EdgeInsets.symmetric(
//                        vertical: 10,
//                        horizontal: 15,
//                      ),
//                      decoration: BoxDecoration(
//                        border: Border.all(
//                          color: Theme.of(context).primaryColor,
//                          width: 2,
//                        )
//                      ),
//                      padding: EdgeInsets.all(10),
//                      child: Text(
//                        '\$${transactions[index].amount.toStringAsFixed(2)}',
//                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 20,
//                          color: Theme.of(context).primaryColor,
//                        ),),
//                    ),
//                    Column( 
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                      Text(
//                        transactions[index].title,
//                        style: Theme.of(context).textTheme.headline6,
//                        ),
//                      Text(
//                        DateFormat.yMMMd().format(transactions[index].date),
//                        style: TextStyle(
//                          color: Colors.grey,
//                          ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );