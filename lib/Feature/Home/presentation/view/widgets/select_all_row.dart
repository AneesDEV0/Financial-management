import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../cubits/home/home_cubit.dart';
import 'home_text_items.dart';

class SelectionRowAll extends StatelessWidget {
  const SelectionRowAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: context.watch<HomeCubit>().isSelectedMode
          ? 1.0
          : 0.0, // Fade in/out the row
      duration: const Duration(milliseconds: 300), // Fade duration
      child: Visibility(
        visible: context.watch<HomeCubit>().isSelectedMode,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.read<HomeCubit>().selectAll();
              },
              child: HomeTextItem(
                  text: context.read<HomeCubit>().selectedItems.length ==
                          context.read<HomeCubit>().filteredData.length
                      ? "الغاء التحديد"
                      : "تحديد الكل"),
            ),
            Row(
              children: [
                AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  duration: const Duration(
                      milliseconds:
                          200), // Duration for the number change animation
                  child: Text(
                    " ${context.read<HomeCubit>().selectedItems.length}",
                    key: ValueKey<int>(context
                        .read<HomeCubit>()
                        .selectedItems
                        .length), // Key to trigger rebuild on number change
                    style: TextStyles.bold13
                        .copyWith(color: AppColor.secndaryColor),
                  ),
                ),
                Text(
                  "  :  العناصر المختارة ",
                  style:
                      TextStyles.bold13.copyWith(color: AppColor.secndaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
