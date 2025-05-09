// ignore_for_file: deprecated_member_use

import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper_functions/build_dialog.dart';
import '../../../../../core/helper_functions/report_dialog.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../add_Financial/presentation/view/add_financial_view.dart';
import 'custom_sort_body.dart';
import 'icon_circle.dart';

class ToolsAppBar extends StatefulWidget {
  const ToolsAppBar({
    super.key,
  });

  @override
  State<ToolsAppBar> createState() => _ToolsAppBarState();
}

class _ToolsAppBarState extends State<ToolsAppBar>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleOpen() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Adjust the width calculation to be more responsive
    double containerWidth =
        MediaQuery.of(context).size.width * (isOpen ? 0.13 : 0.13 * 0.66);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: containerWidth,
      child: SizedBox(
        width: containerWidth,
        height: 40,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            children: [
              GestureDetector(
                onPanDown: (_) {
                  Navigator.pushNamed(context, SettingView.routeName);
                },
                child: CircleIcon(
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              GestureDetector(
                onPanDown: (_) {
                  Navigator.pushReplacementNamed(
                      context, AddFinancialView.routeName);
                },
                child: CircleIcon(
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              if (isOpen)
                GestureDetector(
                  onPanDown: (_) async {
                    createReportDialog(context).show();
                  },
                  child: CircleIcon(
                    child: Icon(
                      Icons.ios_share_sharp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              if (isOpen)
                GestureDetector(
                  onPanDown: (_) {
                    buildDialog(
                      context,
                      const SortingDialogBody(),
                      "تطبيق",
                    );
                  },
                  child: CircleIcon(
                    child: SvgPicture.asset(
                      Assets.imagesSetting4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              GestureDetector(
                onPanDown: (_) {
                  setState(() {
                    isOpen = !isOpen;
                    isOpen ? _controller.forward() : _controller.reverse();
                  });
                },
                child: CircleIcon(
                  child: RotationTransition(
                    turns: Tween(begin: 0.5, end: 0.0).animate(_controller),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
