import 'package:flutter/material.dart';


class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Report for the year'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Below is your report for the year',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.link_sharp, color: Colors.green,),
                SizedBox(width: 10.0,),
                Text('4th September, 2023',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text('Budget Amount - 500'),
                  SizedBox(height: 5.0),
                  Text('Budget percentage - 10%'),
                  SizedBox(height: 5.0),
                  Text('Expenses',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  SizedBox(height: 5.0),
                  Text('Foodstuffs - 200'),
                  SizedBox(height: 5.0),
                  Text('Technology - 100'),
                  SizedBox(height: 5.0),
                  Text('Total Expenses - GHC 300.00'),
                ],
              ),
            ),

            //second
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.link_sharp, color: Colors.green,),
                SizedBox(width: 10.0,),
                Text('5th September, 2023',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text('Budget Amount - 2000'),
                  SizedBox(height: 5.0),
                  Text('Budget percentage - 10%'),
                  SizedBox(height: 5.0),
                  Text('Expenses',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  SizedBox(height: 5.0),
                  Text('Tithe - 200'),
                  SizedBox(height: 5.0),
                  Text('Gifts - 60'),
                  SizedBox(height: 5.0),
                  Text('Total Expenses - GHC 260.00'),
                ],
              ),
            ),

            //third
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.link_sharp, color: Colors.green,),
                SizedBox(width: 10.0,),
                Text('6th September, 2023',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text('Budget Amount - 50'),
                  SizedBox(height: 5.0),
                  Text('Budget percentage - 50%'),
                  SizedBox(height: 5.0),
                  Text('Expenses',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  SizedBox(height: 5.0),
                  Text('Transport - 20.00'),

                  SizedBox(height: 5.0),
                  Text('Total Expenses - GHC 20.00'),
                ],
              ),
            ),

            //fourth
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.link_sharp, color: Colors.green,),
                SizedBox(width: 10.0,),
                Text('7th September, 2023',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text('Budget Amount - 3000'),
                  SizedBox(height: 5.0),
                  Text('Budget percentage - 40%'),
                  SizedBox(height: 5.0),
                  Text('Expenses',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  SizedBox(height: 5.0),
                  Text('Gym - 100'),
                  SizedBox(height: 5.0),
                  Text('Bills - 100'),
                  SizedBox(height: 5.0),
                  Text('Food - 60'),
                  SizedBox(height: 5.0),
                  Text('Total Expenses - GHC 260.00'),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
