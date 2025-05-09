import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/text_styles.dart';

class SubmenuAddButton extends StatelessWidget {
  const SubmenuAddButton({super.key, required this.onSubmited});
  final VoidCallback onSubmited;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: onSubmited,
          color: AppColor.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          child: Text(
            "حفظ",
            style: TextStyles.bold13.copyWith(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("رجوع"),
        ),
      ],
    );
  }
}
