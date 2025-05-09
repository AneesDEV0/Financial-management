import 'package:edaray_applecation/Feature/Home/presentation/view/widgets/home_text_items.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/core/helper_functions/show_error_bart.dart';
import 'package:edaray_applecation/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../add_Financial/presentation/view/widgets/add_app_bar.dart';
import '../../cubits/home/home_cubit.dart';

class EditHistoryViewBody extends StatefulWidget {
  final AddFinancialModel model;
  const EditHistoryViewBody({super.key, required this.model});

  @override
  State<EditHistoryViewBody> createState() => _EditHistoryViewBodyState();
}

class _EditHistoryViewBodyState extends State<EditHistoryViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const AddFundAppBar(
              title: "سجل التعديلات",
              backBtn: false,
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeSeuccess) {
                  var dataSource = context
                      .read<HomeCubit>()
                      .listOfFinancialsHistory
                      .where((item) =>
                          item.funantialNo == widget.model.funantialNo)
                      .toList();
                  if (dataSource.isEmpty) {
                    return const HomeTextItem(text: "سجل التعديلات فارغ ");
                  }
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: HomeTextItem(text: "ملاحظة")),
                            SizedBox(
                                width: 100,
                                child: HomeTextItem(text: "حالة المشروع")),
                            SizedBox(
                                width: 100,
                                child: HomeTextItem(text: "تاريخ التعديل")),
                            SizedBox(
                                width: 100,
                                child: HomeTextItem(text: "اسم المورد")),
                            SizedBox(
                                width: 100,
                                child: HomeTextItem(text: "رقم المعاملة")),
                          ],
                        ),
                        const Divider(), // Optional: Adds a line separator

                        // ListView
                        Expanded(
                          child: ListView.builder(
                            itemCount: dataSource.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: HomeTextItem(
                                        text: dataSource[index].note == ""
                                            ? "لا توجد ملاحظات"
                                            : "${dataSource[index].note}"),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: HomeTextItem(
                                        text: dataSource[index].projectState),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: HomeTextItem(
                                        text:
                                            " ${dataSource[index].editFinancialDate.hour}:${dataSource[index].editFinancialDate.minute} : ${dataSource[index].editFinancialDate.day}/${dataSource[index].editFinancialDate.month}/${dataSource[index].editFinancialDate.year}"),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: HomeTextItem(
                                        text: dataSource[index].supplierName),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: HomeTextItem(
                                        text: dataSource[index].funantialNo),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: CustomBotton(
                              onPressed: () {
                                //TODO NOT IMP
                                buildErrorBar(
                                    context, "الطباعة لا تعمل حاليا !");
                                Navigator.pop(context);
                              },
                              text: "طباعة"),
                        )
                      ],
                    ),
                  );
                } else if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// TODO i want to add ListView inside AwesomeDialog packdge how?
