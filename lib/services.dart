import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xpense_tracker/expense_model.dart';

class Services {
  static const ROOT = 'http://192.168.1.146/flutter_backend/expenses_actions.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EXPENSE_ACTION = 'ADD_EXPENSE';
  static const _UPDATE_EXPENSE_ACTION = 'UPDATE_EXPENSE';
  static const _DELETE_EXPENSE_ACTION = 'DELETE_EXPENSE';
  static const _Add_BUDGET_INFO = 'ADD_BUDGET';
  static const _GET_BUDGET = 'GET_BUDGET';
  static const _UPDATE_BUDGET_INFO = 'UPDATE_BUDGET';

  static Future<List<Expense>> getExpenses() async {
    try {
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body:map);
      //print('Fetch table response: ${response.body}');

      if(200 == response.statusCode){
        List<Expense> list = parseResponse(response.body);
        return list;
      }else{
        return <Expense>[];
      }

    } catch(e) {
      return <Expense>[];
    }
  }

  static List<Expense> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Expense>((json) => Expense.fromJson(json)).toList();
  }

  static List<BudgetInfo> parseBudgetResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BudgetInfo>((json) => BudgetInfo.fromJson(json)).toList();
  }

  static Future<String> addExpense(String title, double amount) async {
    try {
      var map = Map<String,dynamic>();
      map['action'] = _ADD_EXPENSE_ACTION;
      map['title'] = title;
      map['amount'] = amount.toString();

      final response = await http.post(ROOT, body:map);
      //print('Add Expenses response: ${response.body}');

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "Error";
      }

    } catch(e) {
      print(e);
      return "Error";
    }
  }

   static Future<String> updateExpense(String expenseId, String title, double amount) async{
    try {
      var map = Map<String,dynamic>();
      map['action'] = _UPDATE_EXPENSE_ACTION;
      map['id'] = expenseId;
      map['title'] = title;
      map['amount'] = amount.toString();

      final response = await http.post(ROOT, body:map);
      //print('Update Expense response: ${response.body}');

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "Error";
      }

    } catch(e) {
      print(e);
      return "Error";
    }

  }

   static Future<String> deleteExpense(String expenseId) async{
    try {
      var map = Map<String,dynamic>();
      map['action'] = _DELETE_EXPENSE_ACTION;
      map['id'] = expenseId;

      final response = await http.post(ROOT, body:map);
      //print('Delete Expense response: ${response.body}');

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "Error";
      }

    } catch(e) {
      return "Error";
    }
  }

  static Future<String> addBudget(double budget, double percentage, int id) async {
    try {

      var map = Map<String,dynamic> ();

      if(id == 0){
        map['action'] = _Add_BUDGET_INFO;
      }else{
        map['action'] = _UPDATE_BUDGET_INFO;
        map['id'] = id.toString();
      }

      map['budgetAmount'] = budget.toString();
      map['budgetLimitPercentage'] = percentage.toString();

      final response = await http.post(ROOT, body:map);
      //print('Add Expenses response: ${response.body}');

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "Error";
      }

    } catch(e) {
      return "Error";
    }
  }


  static Future<dynamic> getBudget() async {
    try {
      var map = Map<String,dynamic>();
      map['action'] = _GET_BUDGET;
      final response = await http.post(ROOT, body:map);
      //print('Fetch table response: ${response.body}');

      if(200 == response.statusCode){
        List<BudgetInfo> list = parseBudgetResponse(response.body);
        return list;
      }else{
        return BudgetInfo;
      }

    } catch(e) {
      return BudgetInfo;
    }
  }
}