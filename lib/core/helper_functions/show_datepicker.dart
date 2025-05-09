import 'package:flutter/material.dart';

Future<DateTime?> showDatePiker(BuildContext context, DateTime? initDate) {
  return showDatePicker(
    context: context,
    confirmText: "تأكيد",
    cancelText: "الغاء",
    firstDate: DateTime(2010),
    lastDate: DateTime(2100, 1, 1),
    initialDate: initDate ?? DateTime.now(),
  );
}
