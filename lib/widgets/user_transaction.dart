import 'package:flutter/material.dart';
// import 'package:personal_expenses/models/transactions.dart';
// import 'package:personal_expenses/widgets/new_transaction.dart';
// import 'package:personal_expenses/widgets/transactions_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  State < StatefulWidget > createState() => _UserTransactionState();

}

class _UserTransactionState extends State < UserTransaction > {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: < Widget > [
        // NewTransaction(_addNewTransaction),
        //  TransactionList(transaction)
      ],
    );
  }

}