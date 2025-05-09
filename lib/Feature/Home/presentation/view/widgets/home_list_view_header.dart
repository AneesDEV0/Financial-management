import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/home_text_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/utils/app_color.dart';

class HomeListViewHeader extends StatelessWidget {
  const HomeListViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              flex: 10,
              child: HomeTextItem(
                text: "ملاحظات",
                color: AppColor.white,
              )),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: HomeTextItem(
                text: "المجموعة",
                color: AppColor.white,
              )),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: HomeTextItem(
                text: "تاريخ الفاتورة",
                color: AppColor.white,
              )),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: HomeTextItem(
                text: "تاريخ المعاملة",
                color: AppColor.white,
              )),
          SizedBox(width: 12),
          Expanded(
              child: HomeTextItem(
            text: "المشروع",
            color: AppColor.white,
          )),
          SizedBox(width: 12),
          Expanded(
              child: HomeTextItem(
            text: "الاجراء",
            color: AppColor.white,
          )),
          SizedBox(width: 12),
          Expanded(
              child: HomeTextItem(
            text: 'المبلغ',
            color: AppColor.white,
          )),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: HomeTextItem(
                text: "اسم المورد",
                color: AppColor.white,
              )),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: HomeTextItem(
                text: "رقم المعاملة",
                color: AppColor.white,
              )),
        ]),
      ),
    );
  }
}


/*
make custom widget to text feld in home screen
max line 1
overflow clip
overflow ellipsis

*/