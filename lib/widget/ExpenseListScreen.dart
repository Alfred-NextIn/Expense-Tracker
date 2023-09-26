import 'package:xpense_tracker/widget/nav_drawer.dart';

import '../expense_model.dart';
import 'package:flutter/material.dart';

import '../services.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late TextEditingController budgetAmountController;
  late TextEditingController budgetLimitPercentageController;

  late TextEditingController titleController;
  late TextEditingController amountController;

  late List<Expense> expenses; // List to store expenses
  late double realAmount;
  late String amountSpent;
  late List<BudgetInfo> budgetInfo;
  bool _updateBudget = false;

  @override
  void initState() {
    super.initState();
    expenses = [];
    realAmount = 0;
    amountSpent='Expense Tracker';
    budgetInfo = [];
    budgetInfo.add(BudgetInfo(amount: 0.0, budgetPercent: 0.0));

    budgetAmountController = TextEditingController();
    budgetLimitPercentageController = TextEditingController();
    titleController = TextEditingController();
    amountController = TextEditingController();
    _getBudget();
    _getExpenses();


  }

   _getExpenses()
  {
      Services.getExpenses().then((expense){
        setState(() {
          expenses = expense;
        });
        _change_amount_inscription();
      });
  }

  _getBudget()
  {
    Services.getBudget().then((budget){
      setState(() {
        budgetInfo = budget;
      });
    });
  }

   _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });

    Services.addExpense(expense.title, expense.amount).then((result) {
      if(result == 'success'){
         _alert(context, "Your expense has been created successfully");
      }else{
        //print("UNSUCCESSFUL");
      }
    });
    _change_amount_inscription();

  }

  _change_amount_inscription()
  {
    double totalExpenses = expenses.fold(0.0, (sum, item) => sum + item.amount);
    if (totalExpenses > budgetInfo[0].amount * budgetInfo[0].budgetPercent / 100) {
      double amountOver = totalExpenses - budgetInfo[0].amount * budgetInfo[0].budgetPercent / 100;
      _showBudgetLimitPrompt(context, "You have passed your limit by GHC" ,amountOver, Colors.red);
    }
    setState(() {
      amountSpent = 'Amount Spent: GHC '+totalExpenses.toString();
      realAmount = totalExpenses;
    });
  }

  _deleteExpense(index, expenseId) {
    setState(() {
      realAmount = realAmount - expenses[index].amount;
      amountSpent = 'Amount Spent: GHC ' + realAmount.toString();
      expenses.removeAt(index);

    });

    Services.deleteExpense(expenseId).then((expense){
      _change_amount_inscription();
    });

  }

   _updateExpense(index, Expense expense) {
    setState(() {
      //expenses[index].title = expense.title;
      expenses[index] = expense;
    });

    Services.updateExpense(expense.id,expense.title, expense.amount).then((expense){
      _change_amount_inscription();
    });

  }

  _addBudget(budget, percentage, signal) {
    setState(() {
      budgetInfo[0] = BudgetInfo(
        amount: budget,
        budgetPercent: percentage,
      );
    });

    Services.addBudget(budget, percentage,signal).then((budget){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(amountSpent),
        actions: [
          IconButton(
            onPressed: () {
              _setBudget(context);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Icon(Icons.shop, color: index % 2== 0? Colors.green: Colors.grey ),
              title: Text(expenses[index].title),
              subtitle: Text(expenses[index].amount.toString()),
              trailing: IconButton(icon: Icon(Icons.delete_forever, color: Colors.red,), onPressed: () {
                _deleteExpense(index,expenses[index].id);

              },),
            onTap: () {
              //to display the form for update
              _showAddExpenseDialog(context, index);
            },
            //Text(expenses[index].date.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog(context,-1);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Function to show a dialog to add a new expense
  void _showAddExpenseDialog(BuildContext context, index) {
  if(index == -1){
    titleController.text = '';
    amountController.text ='';
  }else{
    titleController.text = expenses[index].title.toString();
    amountController.text = expenses[index].amount.toString();
  }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            index == -1? TextButton(
              onPressed: () {
                // Validate and add the expense
                if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  _addExpense(Expense(
                    id:'',
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    // date: DateTime.now(),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ):TextButton(
              onPressed: () {
                //check if fields are empty, if yes, assign tehm to their old values
                if(titleController.text.isEmpty){
                  titleController.text = expenses[index].title.toString();
                }

                if(amountController.text.isEmpty){
                  amountController.text = expenses[index].amount.toString();
                }

                //calling function
                  _updateExpense(index, Expense(
                    id: expenses[index].id,
                    title: titleController.text,
                    amount: double.parse(amountController.text)
                  ));

                  Navigator.pop(context);
                _alert(context, "Your expense has been updated successfully");
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showReportDialog(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'year'),
                keyboardType: TextInputType.number,
              ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            index == -1? TextButton(
              onPressed: () {
                // Validate and add the expense
                if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  _addExpense(Expense(
                    id:'',
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    // date: DateTime.now(),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ):TextButton(
              onPressed: () {
                //check if fields are empty, if yes, assign tehm to their old values
                if(titleController.text.isEmpty){
                  titleController.text = expenses[index].title.toString();
                }

                if(amountController.text.isEmpty){
                  amountController.text = expenses[index].amount.toString();
                }

                //calling function
                _updateExpense(index, Expense(
                    id: expenses[index].id,
                    title: titleController.text,
                    amount: double.parse(amountController.text)
                ));

                Navigator.pop(context);
                _alert(context, "Your expense has been updated successfully");
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a prompt when expenses exceed the budget limit
  void _showBudgetLimitPrompt(BuildContext context, message, double amountOver, Color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message $amountOver"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).size.height - 170,
            right: 20,
            left: 20
        ),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: Color,
      ),
    );
  }

  void _alert(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).size.height - 170,
            right: 20,
            left: 20
        ),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: Colors.green,
      ),
    );
  }


  // Function to set the budget and budget limit percentage
  void _setBudget(BuildContext context) {
    if(budgetInfo.isNotEmpty){
      budgetAmountController.text = budgetInfo[0].amount.toString();
      budgetLimitPercentageController.text = budgetInfo[0].budgetPercent.toString();
      _updateBudget = true;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Budget and Limit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: budgetAmountController,
                decoration: InputDecoration(labelText: 'Budget Amount'),
                // onChanged: (value) => budgetAmount = value,
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: budgetLimitPercentageController,
                decoration: InputDecoration(labelText: 'Budget Limit Percentage'),
                // onChanged: (value) => budgetLimitPercentage = value,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                 if(budgetAmountController.text.isEmpty){
                   budgetAmountController.text = budgetInfo[0].amount.toString();
                 }

                 if(budgetLimitPercentageController.text.isEmpty){
                   budgetLimitPercentageController.text = budgetInfo[0].budgetPercent.toString();
                 }

                // Validate and set the budget and limit
                if (budgetAmountController.text.isNotEmpty && budgetLimitPercentageController.text.isNotEmpty) {
                  Navigator.pop(context);
                  _updateBudget? _addBudget(double.parse(budgetAmountController.text), double.parse(budgetLimitPercentageController.text),1):_addBudget(double.parse(budgetAmountController.text), double.parse(budgetLimitPercentageController.text), 0);
                  _alert(context, "Your budget has been set Successfully");
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

}