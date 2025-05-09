import 'package:flutter/material.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_textformfeld.dart';

class DateRow extends StatefulWidget {
  final DateTime date;
  final TextEditingController year, month, day;

  const DateRow({
    super.key,
    required this.date,
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Card()),
        Expanded(
          child: CustomTextFormFeld(
              readOnly: true,
              controller: widget.year,
              hintText: "السنة",
              inputType: TextInputType.number),
        ),
        const Text("/", style: TextStyles.bold19),
        Expanded(
          child: CustomTextFormFeld(
              readOnly: true,
              controller: widget.month,
              hintText: "شهر",
              inputType: TextInputType.number),
        ),
        const Text("/", style: TextStyles.bold19),
        Expanded(
          child: CustomTextFormFeld(
              readOnly: true,
              controller: widget.day,
              hintText: "يوم",
              inputType: TextInputType.number),
        ),
      ],
    );
  }
}
