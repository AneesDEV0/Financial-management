import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:edaray_applecation/core/utils/app_images.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoResultsView extends StatelessWidget {
  const NoResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: Column(
        children: [
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Image.asset(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: MediaQuery.sizeOf(context).width * 0.2,
                  Assets.imagesNodata)),
          Center(
            child: Text(
              "عفوًا... هذه المعلومات غير متوفرة في سجلاتك",
              textAlign: TextAlign.center,
              style: TextStyles.semiBold16
                  .copyWith(color: AppColor.lightPrimaryColor),
            ),
          )
        ],
      ),
    );
  }
}
