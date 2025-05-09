import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Feature/Home/presentation/cubits/home/home_cubit.dart';
import '../utils/app_color.dart';

void buildDialog(BuildContext context, Widget child, String okText) {
  AwesomeDialog(
    context: context,
    width: MediaQuery.of(context).size.width * 0.5,
    // dialogBackgroundColor: AppColor.white,
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    body: child,
    btnOkText: okText,
    btnOkOnPress: () {
      context.read<HomeCubit>().sort();
    },
    btnOkColor: AppColor.primaryColor,
  ).show();
}
