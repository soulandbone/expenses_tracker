import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expenses/amount_tf.dart';
import 'package:expense_tracker/widgets/new_expenses/category_ddb.dart';
import 'package:expense_tracker/widgets/new_expenses/date_picker.dart';
import 'package:expense_tracker/widgets/new_expenses/title_tf.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInValid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid values'),
              content: Text(
                'Please make sure a valid title, amount, and date was entered',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void setCategory(value) {
    setState(() {
      _selectedCategory = value!;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TitleTF(_titleController),
              Row(
                children: [
                  Expanded(child: AmountTF(_amountController)),
                  SizedBox(width: 16),
                  Expanded(
                    child: DatePicker(
                      selectedDate: _selectedDate,
                      presentDatePicker: presentDatePicker,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CategoryDropDownButton(
                    selectedCategory: _selectedCategory,
                    setCategory: setCategory,
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,

                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
