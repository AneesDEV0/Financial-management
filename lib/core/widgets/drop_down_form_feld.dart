import 'package:flutter/material.dart';

class DropDownMenuForm extends StatefulWidget {
  const DropDownMenuForm({super.key});

  @override
  State<DropDownMenuForm> createState() => _DropDownMenuFormState();
}

class _DropDownMenuFormState extends State<DropDownMenuForm> {
  String? selectedValue;
  final items = ['Item 1', 'Item 2', 'Item 3'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: const [],
      onChanged: (Object? value) {},
    );
  }
}
