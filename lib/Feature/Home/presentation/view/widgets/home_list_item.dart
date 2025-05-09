import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/home_text_items.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/home_textrich_items.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListViewItem extends StatelessWidget {
  const HomeListViewItem(
      {super.key, required this.item, this.isSelected = false});
  final AddFinancialModel item;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
          horizontal:
              context.read<HomeCubit>().selectedItems.isNotEmpty ? 12.0 : 0),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.lightPrimaryColor.withOpacity(0.5)
                    : Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                    flex: 10,
                    child: HomeTextItem(
                        text: item.note == "" ? "لا توجد ملاحظات" : item.note!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: HomeTextItem(
                        text: item.category == ""
                            ? "عام"
                            : item.category ?? "عام"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      flex: 2,
                      child: HomeTextItem(
                          text:
                              "${item.pillDate.day}/${item.pillDate.month}/${item.pillDate.year}")),
                  const SizedBox(width: 12),
                  Expanded(
                      flex: 2,
                      child: HomeTextItem(
                        text:
                            "${item.financialDate.day}/${item.financialDate.month}/${item.financialDate.year}",
                        color: AppColor.lightPrimaryColor,
                      )),
                  const SizedBox(width: 12),
                  Expanded(child: HomeTextItem(text: item.projectType)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: HomeTextRicItem(
                    text1: item.projectState,
                    text2: "",
                    color1: AppColor.lightPrimaryColor,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child:
                          HomeTextItem(text: "${item.price} ${item.carance}")),
                  const SizedBox(width: 12),
                  Expanded(
                      flex: 2,
                      child: HomeTextItem(
                        text: item.supplierName,
                        color: AppColor.lightPrimaryColor,
                      )),
                  const SizedBox(width: 12),
                  Expanded(
                      flex: 2, child: HomeTextItem(text: item.funantialNo)),
                ]),
              ),
            ),
          ),
          context.read<HomeCubit>().selectedItems.isNotEmpty
              ? isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: AppColor.primaryColor,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: AppColor.lightPrimaryColor,
                    )
              : const SizedBox(),
        ],
      ),
    );
  }
}
