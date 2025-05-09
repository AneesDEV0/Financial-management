import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/text_styles.dart';

class HomeTextRicItem extends StatelessWidget {
  final String text1, text2;
  final Color? color1, color2;
  const HomeTextRicItem(
      {super.key,
      required this.text1,
      required this.text2,
      this.color1,
      this.color2});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(children: [
          TextSpan(
            text: "$text1 ",
            style: color1 == null
                ? TextStyles.bold13
                : TextStyles.bold13.copyWith(color: color1),
          ),
          TextSpan(
            text: text2,
            style: color2 == null
                ? TextStyles.bold13
                : TextStyles.bold13.copyWith(color: color1),
          ),
        ]),
      ),
    );
  }
}
