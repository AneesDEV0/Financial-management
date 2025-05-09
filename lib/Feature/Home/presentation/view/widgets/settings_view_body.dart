// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/add_app_bar.dart';
import 'package:edaray_applecation/core/classes/sharing_data.dart';
import 'package:edaray_applecation/core/helper_functions/show_error_bart.dart';
import 'package:edaray_applecation/core/services/app_services.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:edaray_applecation/core/widgets/custom_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_text_items.dart';
import 'import_bar_settings_view.dart';

enum ImportsTypes { json, excel }

class SettingViewBody extends StatefulWidget {
  const SettingViewBody({super.key});

  @override
  State<SettingViewBody> createState() => _SettingViewBodyState();
}

class _SettingViewBodyState extends State<SettingViewBody> {
  bool darkMode = prefs.getBool('mode') ?? false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: AddFundAppBar(
                      title: 'الاعدادات',
                      onbackClicked: () {},
                    )),
                const Divider(
                  thickness: 3,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: SwitchListTile(
                    title: const Text("الوضع الداكن", style: TextStyles.bold16),
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                      context.read<HomeCubit>().changeTheme();
                    },
                  ),
                ),
                const Divider(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: ListTile(
                      title: const Text("مشاركة البيانات",
                          style: TextStyles.bold16),
                      subtitle: const Text(
                          "قم بمشاركة بياناتك مع الاجهزة الاخرى التي تستخدم التطبيق!"),
                      trailing: SizedBox(
                          width: 120,
                          child: CustomBotton(
                              onPressed: () async {
                                await SharingData.exportJson(
                                    context.read<HomeCubit>().listOfData);
                                buildErrorBar(
                                    context, "تم تصدير الملف الى سطح المكتب");
                              },
                              text: "تصدير"))),
                ),
                const Divider(),
                const ImportBarSettingsView(
                  title: "استيراد البيانات JSON",
                  lable:
                      "قم باختيار الملف لاستيراده عادتا ما يكون بامتداد .json",
                  type: ImportsTypes.json,
                ),
                const ImportBarSettingsView(
                  title: "استيراد البيانات Excel",
                  lable:
                      "قم باختيار الملف لاستيراده عادتا ما يكون بامتداد .xlsx",
                  type: ImportsTypes.excel,
                ),
              ]),
        ),
      ),
    );
  }
}
