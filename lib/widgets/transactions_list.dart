import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List < Transaction > transaction;

  final Function deleteTx;

  TransactionList(this.transaction,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty ? Column(
        children: < Widget > [
          Text("No Transaction added yet", style: Theme.of(context).textTheme.title, ),
          SizedBox(height: 40, ),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',
              fit: BoxFit.cover, ),
          )
        ],
      ) : ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                      child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(child: Text('\$${transaction[index].amount}'))),
              ),
              title: Text(transaction[index].title,
              style: Theme.of(context).textTheme.title,),
              subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: ()=>deleteTx(transaction[index].id),
              ),
            ),
          );
        },
        itemCount: transaction.length
    );
  }

}