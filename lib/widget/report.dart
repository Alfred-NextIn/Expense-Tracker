import 'package:flutter/material.dart';


class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.0),
          Text('Budget Amount - 1000'),
          SizedBox(height: 5.0),
          Text('Budget percentage - 10%'),
          SizedBox(height: 5.0),
          Text('Expenses',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
          SizedBox(height: 5.0),
          Text('Transport - 50'),
          SizedBox(height: 5.0),
          Text('Books - 60'),
          SizedBox(height: 5.0),
          Text('Total Expenses - 60'),
        ],
      ),
    );
  }
}
