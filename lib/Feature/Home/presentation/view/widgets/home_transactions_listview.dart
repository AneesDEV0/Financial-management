import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/home_list_item.dart';
import 'package:edaray_applecation/core/helper_functions/show_error_bart.dart';
import 'package:edaray_applecation/core/helper_functions/show_menu.dart';
import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:edaray_applecation/core/widgets/no_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_all_row.dart';

class HomeTransactionsListView extends StatefulWidget {
  const HomeTransactionsListView({super.key});

  @override
  State<HomeTransactionsListView> createState() =>
      _HomeTransactionsListViewState();
}

class _HomeTransactionsListViewState extends State<HomeTransactionsListView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<HomeCubit>().getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          buildErrorBar(context, state.errorMassage);
        }
      },
      builder: (context, state) {
        if (state is HomeSeuccess) {
          var data = context.watch<HomeCubit>().filteredData;
          data.sort(
            (a, b) => a.financialDate.compareTo(b.financialDate),
          );

          return Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  child: SelectionRowAll(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final isSelected = context
                          .watch<HomeCubit>()
                          .selectedItems
                          .contains(data[index]);

                      return GestureDetector(
                        onTap: () {
                          if (context.read<HomeCubit>().isSelectedMode) {
                            // Toggle item selection
                            context
                                .read<HomeCubit>()
                                .toggleItemSelection(index);
                          }
                        },
                        onSecondaryTapUp: (details) {
                          showModrenMenu(
                              context,
                              details,
                              data[index],
                              context.read<HomeCubit>().selectedItems,
                              index,
                              formKey);
                        },
                        child: HomeListViewItem(
                          item: data[index],
                          isSelected: isSelected,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (state is HomeSearchNoResults) {
          return const Center(
            child: NoResultsView(),
          );
        }
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ما من بيانات هنا بعد, اضف اول معاملة لك",
            style:
                TextStyles.bold16.copyWith(color: AppColor.lightPrimaryColor),
          ),
        ));
      },
    );
  }
}
