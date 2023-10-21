import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Expense {
  final String title;
  final double amount;
  final String category;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
  });
}

class ExpenseTrackerApp extends StatefulWidget {
  @override
  _ExpenseTrackerAppState createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Expense> expenses = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  double getTotalExpenses() {
    return expenses.fold(0, (double sum, Expense expense) => sum + expense.amount);
  }

  void _addExpense() {
    final String title = titleController.text;
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String category = categoryController.text;

    if (title.isNotEmpty && amount > 0 && category.isNotEmpty) {
      setState(() {
        expenses.add(Expense(title: title, amount: amount, category: category));
      });

      titleController.clear();
      amountController.clear();
      categoryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Expense Title'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addExpense,
                child: Text('Add Expense'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Expenses: \$${getTotalExpenses().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return ListTile(
                      title: Text(expense.title),
                      subtitle: Text('${expense.amount.toStringAsFixed(2)} (${expense.category})'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseTrackerApp(),
    );
  }
}
