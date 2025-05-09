// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edaray_applecation/core/helper_functions/genarate_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Feature/Home/presentation/cubits/home/home_cubit.dart';
import '../utils/app_color.dart';
import 'generate_single_transaction_pdf.dart';

AwesomeDialog createReportDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: MediaQuery.sizeOf(context).width * .4,
    padding: const EdgeInsets.all(20),
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    title: "اشعار",
    desc:
        "انت على وشك اعداد تقرير ل ${context.read<HomeCubit>().selectedItems.isEmpty ? context.read<HomeCubit>().filteredData.length : context.read<HomeCubit>().selectedItems.length} سجلات",
    btnCancelText: "الغاء",
    btnCancelOnPress: () {},
    btnOkText: "متابعة",
    btnOkOnPress: () async {
      if (context.read<HomeCubit>().selectedItems.isEmpty) {
        await generateFinancialReportPdf(
            context.read<HomeCubit>().filteredData);
      } else {
        await generateMultipleTransactionsPdf(
            context.read<HomeCubit>().selectedItems);
        context.read<HomeCubit>().selectedItems.clear();
        context.read<HomeCubit>().enableSelectMode();
      }
      AwesomeDialog(
              context: context,
              width: MediaQuery.sizeOf(context).width * .4,
              padding: const EdgeInsets.all(20),
              animType: AnimType.scale,
              dialogType: DialogType.success,
              headerAnimationLoop: false,
              title: "تمت حفظ التقرير بنجاح",
              desc: "reports يمكنك دائما الاطلاع عللى تقاريرك من مجلد",
              btnOkOnPress: () {},
              btnOkText: "فهمت",
              btnOkColor: AppColor.primaryColor)
          .show();
    },
  );
}
