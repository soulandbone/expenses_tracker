import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryDropDownButton extends StatelessWidget {
  const CategoryDropDownButton({
    required this.selectedCategory,
    required this.setCategory,
    super.key,
  });

  final Category selectedCategory;
  final void Function(Category?) setCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items:
          Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                ),
              )
              .toList(),
      onChanged: (value) {
        setCategory(value);
      },
    );
  }
}
