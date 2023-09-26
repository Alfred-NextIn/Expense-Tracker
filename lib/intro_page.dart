import 'package:flutter/material.dart';
import 'package:xpense_tracker/widget/ExpenseListScreen.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade500,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250.0,
              ),
              Text.rich(
                TextSpan(
                  text: "Expense Tracker",
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70.0,
                child: Icon(
                  Icons.stacked_bar_chart_outlined,
                  size: 100,
                  color: Colors.blue.shade500,
                ),
              ),
              SizedBox(height: 20.0),
              Text("Track all your expenses...",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ExpenseListScreen();
                  }));
                },
                child: Text("Start Now!",),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(150.0, 50.0),
                foregroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 14.0)),
              )
            ],
          ),
        ));
  }
}
