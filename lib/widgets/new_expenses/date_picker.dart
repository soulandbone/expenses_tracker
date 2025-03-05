import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class DatePicker extends StatelessWidget {
  const DatePicker({
    required this.selectedDate,
    required this.presentDatePicker,
    super.key,
  });

  final DateTime? selectedDate;
  final void Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'No Date selected'
              : formatter.format(selectedDate!),
        ),
        IconButton(
          onPressed: presentDatePicker,
          icon: Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
