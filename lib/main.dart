import 'package:flutter/material.dart';
import 'package:xpense_tracker/intro_page.dart';
//import 'package:xpense_tracker/widget/ExpenseListScreen.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}


