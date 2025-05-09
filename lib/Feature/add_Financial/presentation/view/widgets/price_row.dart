import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/widgets/custom_textformfeld.dart';
import 'custom_labole.dart';
import 'custom_optionmenu.dart';

class PriceRow extends StatelessWidget {
  const PriceRow(
      {super.key,
      this.onSaved,
      required this.carance,
      required this.caranceList,
      this.controller,
      this.focusNode,
      this.onSubmit});
  final void Function(String?)? onSaved;
  final TextEditingController carance;
  final TextEditingController? controller;
  final List<String> caranceList;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl, // Align Row contents in RTL
      children: [
        SizedBox(
          width: 250,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: CustomTextFormFeld(
              focusMode: focusNode,
              controller: controller,
              onSaved: onSaved,
              hintText: "المبلغ",
              inputType: TextInputType.number,
              onSubmit: onSubmit,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: 150,
                height: 45,
                child: CustomOptionMenu(
                  controller: carance,
                  optionsList: caranceList,
                )),
            const CustomLablole(
              txt: 'العملة',
            ),
          ],
        ),
      ],
    );
  }
}
