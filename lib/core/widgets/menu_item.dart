import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/text_styles.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(icon),
      title: Expanded(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            textAlign: TextAlign.end,
            title,
            style: TextStyles.bold13.copyWith(color: AppColor.secndaryColor),
          ),
        ),
      ),
    );
  }
}
