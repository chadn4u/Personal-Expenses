import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget{
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);
  
  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for(int a = 0; a < recentTransaction.length; a++){
          if(recentTransaction[a].date.day == weekDay.day && 
          recentTransaction[a].date.month == weekDay.month &&
          recentTransaction[a].date.year == weekDay.year){
            totalSum += recentTransaction[a].amount;
          }
      }


      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount':totalSum
      };
    });
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum,item){
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
  //  print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data){
          return ChartBar(data['day'],data['amount'],(data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }


}