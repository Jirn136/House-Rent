import 'package:flutter/material.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class DateSelection extends StatefulWidget {
  final Function(int) selectedDate;

  const DateSelection({super.key, required this.selectedDate});

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.selectedDate(pickedDate.millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18.0,
        top: 8,
      ),
      child: TextButton.icon(
        onPressed: () => _selectDate(context),
        icon: const Icon(
          Icons.calendar_month_outlined,
        ),
        label: Text(
          _selectedDate == null
              ? Constants.titleSelectDate
              : (_selectedDate!.millisecondsSinceEpoch).formatDate(),
        ),
      ),
    );
  }
}
