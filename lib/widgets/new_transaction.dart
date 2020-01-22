import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:personal_expenses/widgets/user_transaction.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData(){
    final enteredTittleData = titleController.text;
    final enteredAmountData = double.parse(amountController.text);

    if(enteredTittleData.isEmpty || enteredAmountData <= 0){
        return;
    }

    widget.addTx(titleController.text,
                      double.parse(amountController.text));

     Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: < Widget > [
                  TextField(decoration: InputDecoration(
                      labelText: 'Title'
                    ),
                    controller: titleController,
                    onSubmitted: (_)=> submitData(),
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly], 
                    decoration: InputDecoration(
                      labelText: 'Amount'),
                    controller: amountController,
                    onSubmitted: (_) => submitData(),
                  ),
                  FlatButton(
                    child: Text('Add Transaction'),
                    textColor: Colors.purple,
                    onPressed: submitData,
                  )
                ],
              ),
            ),
          );
  }
}