import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class CustomBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomBotton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            // backgroundColor: AppColor.primaryColor,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Theme.of(context).colorScheme.error))),
        child: Text(
          text,
          style: TextStyles.bold16,
        ),
      ),
    );
  }
}
