import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  // Constructor to initialize callback function
  MonthYearPicker({required this.onDateSelected});

  @override
  _MonthYearPickerState createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show the month and year picker dialog
        DateTime? selectedDate = await showMonthYearPicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (selectedDate != null) {
          setState(() {
            _selectedDate = selectedDate;
          });

          // Call the callback function with the selected date
          widget.onDateSelected(selectedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Select Month & Year",
          border: OutlineInputBorder(),
        ),
        child: Text(
          DateFormat('MMMM yyyy').format(_selectedDate),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

Future<DateTime?> showMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
           buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    // Return only the selected month and year
    return DateTime(pickedDate.year, pickedDate.month);
  }
  return null;
}
