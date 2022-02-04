import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';


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
             return TransactionItem(transaction: transactions[index], deletTx: deletTx);  },
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