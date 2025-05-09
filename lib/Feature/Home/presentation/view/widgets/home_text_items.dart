import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/text_styles.dart';

class HomeTextItem extends StatelessWidget {
  final String text;
  final Color? color;
  const HomeTextItem({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        text,
        style: color == null
            ? TextStyles.bold13
            : TextStyles.bold13.copyWith(color: color),
      ),
    );
  }
}
