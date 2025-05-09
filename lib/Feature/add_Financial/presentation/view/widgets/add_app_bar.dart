import 'dart:math';
import 'package:edaray_applecation/Feature/Home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_styles.dart';

class AddFundAppBar extends StatelessWidget {
  final String title;
  final bool? backBtn;
  final VoidCallback? onbackClicked;
  const AddFundAppBar(
      {super.key,
      required this.title,
      this.backBtn = true,
      this.onbackClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyles.bold19.copyWith(color: AppColor.secndaryColor),
        ),
        backBtn!
            ? IconButton(
                onPressed: () {
                  onbackClicked;

                  // Navigator.pop(context)
                  Navigator.of(context).pushReplacementNamed(HomeView.routeName);
                },
                icon: Transform.rotate(
                    angle: pi,
                    child: const Icon(Icons.arrow_back_ios_new_sharp)))
            : Container()
      ],
    );
  }
}
