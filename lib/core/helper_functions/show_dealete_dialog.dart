import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Feature/Home/presentation/cubits/home/home_cubit.dart';
import '../../Feature/add_Financial/data/model/add_financial_model.dart';

AwesomeDialog showDealeteDialog(BuildContext context, AddFinancialModel model,
    List<AddFinancialModel>? data) {
  return AwesomeDialog(
    context: context,
    width: MediaQuery.sizeOf(context).width * .4,
    padding: const EdgeInsets.all(20),
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    title: 'اشعار هام',
    desc: data!.isNotEmpty
        ? "هل انت متأكد من انك تريد حذف ${data.length} من العناصر"
        : 'هل انت متأكد من انك تريد حذف المعاملة صاحبة الرقم ${(model).funantialNo}',
    btnCancelText: "الغاء",
    btnOkText: "تأكيد",
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      if (data.isNotEmpty) {
        context.read<HomeCubit>().dealte(model, data);
      } else {
        context.read<HomeCubit>().dealte(model, null);
      }
    },
  );
}
