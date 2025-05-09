import 'package:edaray_applecation/core/widgets/custom_inputborder.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/text_styles.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.splierName,
      required this.text,
      required this.splaiers,
      this.initialValue,
      this.focusMode,
      this.onSelected});

  final TextEditingController splierName;
  final String text;
  final List<String> splaiers;
  final String? initialValue;
  final FocusNode? focusMode;
  final void Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    final uniqueItems = <String>{}; // Using a Set to store unique items
    if (initialValue != null && initialValue!.isNotEmpty) {
      splierName.text = initialValue!;
    }
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL direction
      child: Focus(
        focusNode: focusMode,
        child: DropdownMenu(
          controller: splierName,
          requestFocusOnTap: true,
          width: 555,
          enableFilter: true,
          enableSearch: true,
          hintText: text,
          textStyle: TextStyles.bold13,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: customInputBorder(context),
            focusedBorder: customInputBorder(context),
            fillColor: const Color(0xffE6E9EA),
          ),
          dropdownMenuEntries: splaiers
              .where((e) =>
                  uniqueItems.add(e)) // Adds only unique items to the Set
              .map((e) => DropdownMenuEntry(value: e, label: e))
              .toList(),
          // splaiers.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
          onSelected: onSelected,
        ),
      ),
    );
  }
}
