import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses%20list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
    this.onRemoveExpenses, {
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;
  final Function onRemoveExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) => onRemoveExpenses(expenses[index]),
            child: ExpensesItem(expenses[index]),
          ),
    );
  }
}
