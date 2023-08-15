// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'expense_model.dart';
//
// class ExpenseListScreen extends StatefulWidget {
//   @override
//   _ExpenseListScreenState createState() => _ExpenseListScreenState();
// }
//
// class _ExpenseListScreenState extends State<ExpenseListScreen> {
//   List<Expense> expenses = [];
//   BudgetInfo budgetInfo = BudgetInfo(budgetAmount: 0.0, budgetLimitPercentage: 0.0);
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBudgetInfo();
//   }
//
//   void _loadBudgetInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final Map<String, dynamic>? budgetMap = prefs.get('budgetInfo');
//     if (budgetMap != null) {
//       setState(() {
//         budgetInfo = BudgetInfo.fromMap(budgetMap);
//       });
//     }
//   }
//
//   void _saveBudgetInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('budgetAmount', budgetInfo.budgetAmount);
//     await prefs.setDouble('budgetLimitPercentage', budgetInfo.budgetLimitPercentage);
//   }
//
//   void _addExpense(Expense expense) {
//     setState(() {
//       expenses.add(expense);
//     });
//
//     // Check if expenses exceed the budget limit
//     double totalExpenses = expenses.fold(0.0, (sum, item) => sum + item.amount);
//     if (totalExpenses > budgetInfo.budgetAmount * budgetInfo.budgetLimitPercentage / 100) {
//       _showBudgetLimitPrompt(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense Tracker'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _showBudgetDialog(context);
//             },
//             icon: Icon(Icons.settings),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: expenses.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(expenses[index].title),
//             subtitle: Text(expenses[index].amount.toString()),
//             trailing: Text(expenses[index].date.toString()),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddExpenseDialog(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showAddExpenseDialog(BuildContext context) {
//     // ... Same as before ...
//   }
//
//   void _showBudgetLimitPrompt(BuildContext context) {
//     // ... Same as before ...
//   }
//
//   void _showBudgetDialog(BuildContext context) {
//     String budgetAmount = '';
//     String budgetLimitPercentage = '';
//     TextEditingController budgetAmountController = TextEditingController();
//     TextEditingController budgetLimitPercentageController = TextEditingController();
//
//     budgetAmountController.text = budgetInfo.budgetAmount.toString();
//     budgetLimitPercentageController.text = budgetInfo.budgetLimitPercentage.toString();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Set Budget and Limit'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: budgetAmountController,
//                 decoration: InputDecoration(labelText: 'Budget Amount'),
//                 onChanged: (value) => budgetAmount = value,
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: budgetLimitPercentageController,
//                 decoration: InputDecoration(labelText: 'Budget Limit Percentage'),
//                 onChanged: (value) => budgetLimitPercentage = value,
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Validate and set the budget and limit
//                 if (budgetAmount.isNotEmpty && budgetLimitPercentage.isNotEmpty) {
//                   setState(() {
//                     budgetInfo.budgetAmount = double.parse(budgetAmount);
//                     budgetInfo.budgetLimitPercentage = double.parse(budgetLimitPercentage);
//                   });
//                   _saveBudgetInfo();
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
