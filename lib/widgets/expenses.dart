import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/chart/cahrt.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredexpenselist = [
    Expense(
      titile: 'Flutter Course',
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      titile: 'Cinema',
      amount: 19.9,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void ExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addexpenses),
    );
  }

  void addexpenses(Expense expense) {
    setState(() {
      registeredexpenselist.add(expense);
    });
  }

  void Removeexpense(Expense expense) {
    final ExpenseIndex = registeredexpenselist.indexOf(expense);
    setState(() {
      registeredexpenselist.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredexpenselist.insert(ExpenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (registeredexpenselist.isNotEmpty) {
      maincontent = Expenselist(
        expenses: registeredexpenselist,
        removeExpense: Removeexpense,
      );
    }
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Expense Tracker'), actions: [
          IconButton(
            onPressed: ExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ]),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: registeredexpenselist),
                  Expanded(child: maincontent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: registeredexpenselist)),
                  Expanded(child: maincontent)
                ],
              ));
  }
}
