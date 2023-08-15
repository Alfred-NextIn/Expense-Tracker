class Expense {
  String id;
  late final String title;
  late final double amount;
  // final DateTime date;

  Expense({required this.id, required this.title, required this.amount});

  factory Expense.fromJson(Map<String, dynamic> json){
    return Expense(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: double.parse(json['amount']),
      // date: json['date_created'] as DateTime,

    );
  }
}

class BudgetInfo {
  double amount;
  double budgetPercent;

  BudgetInfo({
    required this.amount,
    required this.budgetPercent,
  });

  factory BudgetInfo.fromJson(Map<String, dynamic> json) => BudgetInfo(
    amount: double.parse(json["amount"]),
    budgetPercent: double.parse(json["budget_percent"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "budget_percent": budgetPercent,
  };
}