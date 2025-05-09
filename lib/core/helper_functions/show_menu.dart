// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/edit_view_body.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/core/helper_functions/generate_single_transaction_pdf.dart';
import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Feature/Home/presentation/cubits/home/home_cubit.dart';
import '../../Feature/Home/presentation/view/widgets/edit_history_view_body.dart';
import 'show_dealete_dialog.dart';

Future showModrenMenu<T extends HiveObject>(
    BuildContext context,
    TapUpDetails details,
    AddFinancialModel model,
    List<AddFinancialModel>? data,
    int index,
    GlobalKey<FormState> formKey) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  showMenu(
    context: context,
    elevation: 20,
    color: Theme.of(context).popupMenuTheme.color,
    position: RelativeRect.fromRect(
      Rect.fromPoints(
        details.globalPosition,
        details.globalPosition,
      ),
      Offset.zero & overlay.size,
    ),
    items: [
      if (context.read<HomeCubit>().isSelectedMode == false) ...[
        const PopupMenuItem(
          value: 'select',
          child: SecondMenuItem(
          
            title: "تحديد",
            icon: Icons.checklist_rtl_sharp,
          ),
        ),
      ],
      const PopupMenuItem(
          value: 'update',
          child: SizedBox(
              height: 20,
              child: SecondMenuItem(title: "تعديل", icon: Icons.edit))),
      PopupMenuItem(
          value: 'delete',
          child: SizedBox(
            height: 20,
            child: SecondMenuItem(
                title: context.read<HomeCubit>().selectedItems.isEmpty
                    ? 'حذف'
                    : "حذف ${context.read<HomeCubit>().selectedItems.length} عناصر",
                icon: Icons.delete_outline_outlined),
          )),
      const PopupMenuItem(
          value: 'historyList',
          child: SizedBox(
              height: 20,
              child:
                  SecondMenuItem(title: 'سجل التعديلات', icon: Icons.history))),
      PopupMenuItem(
          value: 'report',
          child: Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 20,
              child: SecondMenuItem(
                  title: context.read<HomeCubit>().selectedItems.isEmpty
                      ? 'اصدار تقريير'
                      : 'اصدار تقريير ل ${context.read<HomeCubit>().selectedItems.length} عناصر ',
                  icon: Icons.ios_share_rounded),
            ),
          )),
    ],
  ).then((value) async {
    if (value == "select") {
      context.read<HomeCubit>().enableSelectMode();
      context.read<HomeCubit>().toggleItemSelection(index);
    }
    if (value == 'update') {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.noHeader,
        body: EditViewBody(
          model: model,
        ),
      ).show();
    } else if (value == 'delete') {
      showDealeteDialog(context, model, data).show();
    } else if (value == "historyList") {
      AwesomeDialog(
        context: context,
        width: MediaQuery.of(context).size.width * .7,
        animType: AnimType.scale,
        dialogType: DialogType.noHeader,
        body: EditHistoryViewBody(
          model: model,
        ),
      ).show();
    } else if (value == "report") {
      if (model != null) {
        await generateMultipleTransactionsPdf([model]);
        if (data!.isNotEmpty) {
          await generateMultipleTransactionsPdf(data);
        }
        AwesomeDialog(
                context: context,
                width: MediaQuery.of(context).size.width * .4,
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
      }
    }
  });
}

class SecondMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const SecondMenuItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: TextStyles.bold13),
          const SizedBox(width: 8), // Add space between the icon and text
          Icon(icon),
        ],
      ),
    );
  }
}


// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/edit_view_body.dart';
// import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
// import 'package:edaray_applecation/core/helper_functions/generate_single_transaction_pdf.dart';
// import 'package:edaray_applecation/core/utils/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../../Feature/Home/presentation/cubits/home/home_cubit.dart';
// import '../../Feature/Home/presentation/view/widgets/edit_history_view_body.dart';
// import '../widgets/menu_item.dart';
// import 'show_dealete_dialog.dart';

// Future showModrenMenu<T extends HiveObject>(
//     BuildContext context,
//     TapUpDetails details,
//     AddFinancialModel model,
//     List<AddFinancialModel>? data,
//     int index,
//     GlobalKey<FormState> formKey) async {
//   final RenderBox overlay =
//       Overlay.of(context).context.findRenderObject() as RenderBox;

//   showMenu(
//     context: context,
//     // color: Color.fromARGB(255, 255, 255, 255),
//     elevation: 20,

//     position: RelativeRect.fromRect(
//       // Use the position of the cursor from TapUpDetails
//       Rect.fromPoints(
//         details.globalPosition,
//         details.globalPosition,
//       ),
//       Offset.zero & overlay.size,
//     ),
//     items: [
//       if (context.read<HomeCubit>().isSelectedMode == false) ...[
//         const PopupMenuItem(
//           value: 'select',
//           child: MenuItem(
//             title: 'تحديد',
//             icon: Icons.checklist_rtl_sharp,
//           ),
//         ),
//       ],
//       const PopupMenuItem(
//           value: 'update', child: MenuItem(title: "تعديل", icon: Icons.edit)),
//       PopupMenuItem(
//           value: 'delete',
//           child: MenuItem(
//               title: context.read<HomeCubit>().selectedItems.isEmpty
//                   ? 'حذف'
//                   : "حذف ${context.read<HomeCubit>().selectedItems.length} عناصر",
//               icon: Icons.delete_outline_outlined)),
//       const PopupMenuItem(
//           value: 'historyList',
//           child: MenuItem(title: 'سجل التعديلات', icon: Icons.history)),
//       PopupMenuItem(
//           value: 'report',
//           child: Align(
//             alignment: Alignment.bottomRight,
//             child: MenuItem(
//                 title: context.read<HomeCubit>().selectedItems.isEmpty
//                     ? 'اصدار تقريير'
//                     : 'اصدار تقريير ل ${context.read<HomeCubit>().selectedItems.length} عناصر ',
//                 icon: Icons.ios_share_rounded),
//           )),
//     ],
//   ).then((value) async {
//     if (value == "select") {
//       context.read<HomeCubit>().enableSelectMode();
//       context.read<HomeCubit>().toggleItemSelection(index);
//     }
//     if (value == 'update') {
//       AwesomeDialog(
//         context: context,
//         animType: AnimType.scale,
//         dialogType: DialogType.noHeader,
//         body: EditViewBody(
//           model: model,
//         ),
//       ).show();
//     } else if (value == 'delete') {
//       showDealeteDialog(context, model, data).show();
//     } else if (value == "historyList") {
//       AwesomeDialog(
//         context: context,
//         width: MediaQuery.sizeOf(context).width * .7,
//         animType: AnimType.scale,
//         dialogType: DialogType.noHeader,
//         body: EditHistoryViewBody(
//           model: model,
//         ),
//       ).show();
//     } else if (value == "report") {
//       if (model != null) {
//         await generateMultipleTransactionsPdf([model]);
//         if (data != null) {
//           await generateMultipleTransactionsPdf(data);
//         }
//         AwesomeDialog(
//                 context: context,
//                 width: MediaQuery.sizeOf(context).width * .4,
//                 padding: const EdgeInsets.all(20),
//                 animType: AnimType.scale,
//                 dialogType: DialogType.success,
//                 headerAnimationLoop: false,
//                 title: "تمت حفظ التقرير بنجاح",
//                 desc: "reports يمكنك دائما الاطلاع عللى تقاريرك من مجلد",
//                 btnOkOnPress: () {},
//                 btnOkText: "فهمت",
//                 btnOkColor: AppColor.primaryColor)
//             .show();
//       }
//     }
//   });
// }
