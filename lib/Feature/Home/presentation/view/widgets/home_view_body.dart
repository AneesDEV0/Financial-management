import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/core/helper_functions/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper_functions/build_dialog.dart';
import '../../../../add_Financial/presentation/view/add_financial_view.dart';
import 'custom_sort_body.dart';
import 'home_appbar.dart';
import 'home_list_view_header.dart';
import 'home_transactions_listview.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool isCtrlPressed = false;

  @override
  void initState() {
    print("==============");
    super.initState();
    context.read<HomeCubit>().focusNode.requestFocus();
  }

  @override
  void dispose() {
    context.read<HomeCubit>().focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: context.read<HomeCubit>().focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.controlLeft ||
              event.logicalKey == LogicalKeyboardKey.controlRight) {
            setState(() => isCtrlPressed = true);
          }
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }

          if (isCtrlPressed) {
            if (event.logicalKey == LogicalKeyboardKey.keyQ) {
              Navigator.pushNamed(context, AddFinancialView.routeName);
            } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
              buildDialog(context, const SortingDialogBody(), "تطبيق");
            } else if (event.logicalKey == LogicalKeyboardKey.keyE) {
              createReportDialog(context).show();
            }
          }
        }

        if (event is KeyUpEvent) {
          if (event.logicalKey == LogicalKeyboardKey.controlLeft ||
              event.logicalKey == LogicalKeyboardKey.controlRight) {
            setState(() => isCtrlPressed = false);
          }
        }
      },
      child: const Column(
        children: [
          HomeAppBar(),
          HomeListViewHeader(),
          HomeTransactionsListView()
        ],
      ),
    );
  }
}
