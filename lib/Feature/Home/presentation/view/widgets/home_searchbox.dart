import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/widgets/custom_textformfeld.dart';
import '../../cubits/home/home_cubit.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomTextFormFeld(
          hintText: 'ابحث عن معاملة هنا',
          inputType: TextInputType.text,
          icon: SvgPicture.asset(
            fit: BoxFit.none,
            Assets.imagesSearch,
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.help_outline,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              AwesomeDialog(
                width: MediaQuery.sizeOf(context).width * .5,
                padding: const EdgeInsets.only(bottom: 25, right: 20, left: 20),
                dialogType: DialogType.noHeader,
                context: context,
                body: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Card(
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 8.0),
                              child: Text(
                                "مفاتيح البحث",
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text("ادخل اسم المورد للبحث عن المعاملات المرتبطة به"),
                    SizedBox(height: 4),
                    Text('ادخل نوع المشروع للبحث عن المعاملات المرتبطة به'),
                    SizedBox(height: 4),
                    Text(
                        'ادخل علامة "%" ثم اسم المجموعة للبحث عن المعاملات المرتبطة بها'),
                    SizedBox(height: 4),
                    Text("السنة - للبحث عن المعاملات التي صدرت في سنة معينة/"),
                    SizedBox(height: 4),
                    Text(
                        "الشهر/السنة - للبحث عن المعاملات التي صدرت في شهر معين"),
                    SizedBox(height: 4),
                    Text(
                        "اليوم/الشهر/السنة - للبحث عن المعاملات التي صدرت في يوم معين"),
                    SizedBox(height: 4),
                  ],
                ),
              ).show();
            },
          ),
          onSubmit: (p0) {
            context.read<HomeCubit>().search(p0);
          },
        ),
      ),
    );
  }
}
