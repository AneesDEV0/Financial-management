
import 'package:flutter/material.dart';


import '../../../../../core/utils/text_styles.dart';
import 'home_searchbox.dart';
import 'tools_appbar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.transparent,
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    // boxShadow: const [
                    //   BoxShadow(
                    //       color: AppColor.lightPrimaryColor,
                    //       blurRadius: 200,
                    //       spreadRadius: 0.0)
                    // ],
                  ),
                  child: const ToolsAppBar(),
                ),
              ),
              const SearchBarHome(),
              const Text(
                "..!صباح الخير ",
                style: TextStyles.regular16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
