import 'package:flutter/material.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_inputborder.dart';

class CustomOptionMenu extends StatelessWidget {
  const CustomOptionMenu({
    super.key,
    required this.controller,
    required this.optionsList,
    this.noteController,
    this.onSelected,
  });
  final TextEditingController controller;
  final List<String> optionsList;
  final TextEditingController? noteController;
  final void Function(String?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: controller,
      expandedInsets: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      textStyle: TextStyles.bold13,
      inputDecorationTheme: InputDecorationTheme(
        border: customInputBorder(context),
      ),
      // enableFilter: true,

      // Set min width here
      dropdownMenuEntries: optionsList
          .map((e) => DropdownMenuEntry(value: e, label: e))
          .toList(),
      onSelected: onSelected,
    );
  }
}
