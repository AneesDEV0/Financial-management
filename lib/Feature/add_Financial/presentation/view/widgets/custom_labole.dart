import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_styles.dart';

class CustomLablole extends StatelessWidget {
  const CustomLablole({
    super.key,
    required this.txt,
  });
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Text(
        txt,
        style: TextStyles.bold13.copyWith(
          color: AppColor.green50,
        ),
      ),
    );
  }
}
