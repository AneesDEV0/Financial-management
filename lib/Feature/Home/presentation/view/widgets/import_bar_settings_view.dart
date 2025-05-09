// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/classes/sharing_data.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../add_Financial/data/model/add_financial_model.dart';
import '../../cubits/home/home_cubit.dart';
import 'home_text_items.dart';

class ImportBarSettingsView extends StatelessWidget {
  final String title;
  final String lable;
  final ImportsTypes type;
  const ImportBarSettingsView({
    super.key,
    required this.title,
    required this.lable,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: ListTile(
          title: Text(title, style: TextStyles.bold16),
          subtitle: Text(
            lable,
          ),
          trailing: SizedBox(
              width: 120,
              child: CustomBotton(
                  onPressed: () async {
                    List<AddFinancialModel> data = [];
                    if (type == ImportsTypes.excel) {
                      data = await SharingData.importExcel(context);
                    } else if (type == ImportsTypes.json) {
                      data = await SharingData.importJson(context);
                    }
                    if (data.isNotEmpty) {
                      AwesomeDialog(
                              width: MediaQuery.sizeOf(context).width * .6,
                              context: context,
                              dialogType: DialogType.noHeader,
                              title: "البيانات",
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Divider()),
                                        Text(
                                          'البيانات',
                                          style: TextStyles.bold19,
                                        ),
                                        Expanded(child: Divider()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 400,
                                    child: ListView.separated(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        List<AddFinancialModel> dataSource =
                                            data;
                                        return Opacity(
                                          opacity: context
                                                  .read<HomeCubit>()
                                                  .listOfData
                                                  .contains(data[index])
                                              ? 0.2
                                              : 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: HomeTextItem(
                                                    text: dataSource[index]
                                                                .note ==
                                                            ""
                                                        ? "لا توجد ملاحظات"
                                                        : "${dataSource[index].note}"),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: HomeTextItem(
                                                    text: dataSource[index]
                                                        .projectState),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: HomeTextItem(
                                                    text:
                                                        "  ${dataSource[index].financialDate.day}/${dataSource[index].financialDate.month}/${dataSource[index].financialDate.year}"),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: HomeTextItem(
                                                    text: dataSource[index]
                                                        .supplierName),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: HomeTextItem(
                                                    text: dataSource[index]
                                                        .funantialNo),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Divider(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              btnOk: CustomBotton(
                                  onPressed: () {
                                    for (var element in data) {
                                      if (context
                                          .read<HomeCubit>()
                                          .listOfData
                                          .contains(element)) {
                                        continue;
                                      }
                                      context.read<HomeCubit>().add(element);
                                    }
                                    Navigator.pop(context);
                                  },
                                  text: "استيراد"),
                              btnOkColor: Theme.of(context).splashColor)
                          .show();
                    }
                  },
                  text: "استيراد"))),
    );
  }
}
