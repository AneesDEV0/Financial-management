import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/custom_labole.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/price_row.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/submit_button.dart';
import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:edaray_applecation/core/widgets/custom_textformfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../constants.dart';
import '../../../../../core/helper_functions/show_datepicker.dart';
import '../../../../add_Financial/presentation/view/widgets/add_app_bar.dart';
import '../../../../add_Financial/presentation/view/widgets/custom_dropdown.dart';
import '../../../../add_Financial/presentation/view/widgets/custom_optionmenu.dart';
import '../../../../add_Financial/presentation/view/widgets/date_row.dart';

class EditViewBody extends StatefulWidget {
  final AddFinancialModel model;

  const EditViewBody({super.key, required this.model});

  @override
  State<EditViewBody> createState() => _EditViewBodyState();
}

class _EditViewBodyState extends State<EditViewBody> {
  DateTime? dateTime;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController funantialNoController,
      year,
      month,
      day,
      priceController,
      carance,
      projectState,
      projectType,
      noteController,
      categorysController,
      splierName;
  // late String funantialNo, price, note;
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  List<String> carrances = ["NIS", "USD", "EUR"];
  List<String> splaiers = [];
  List<String> categorys = [];

  @override
  void initState() {
    funantialNoController =
        TextEditingController(text: widget.model.funantialNo);
    year = TextEditingController(text: widget.model.pillDate.year.toString());
    month = TextEditingController(text: widget.model.pillDate.month.toString());
    day = TextEditingController(text: widget.model.pillDate.day.toString());
    carance = TextEditingController(text: widget.model.carance);
    priceController = TextEditingController(text: widget.model.price);
    projectState = TextEditingController(text: widget.model.projectState);
    splierName = TextEditingController(text: widget.model.supplierName);
    noteController = TextEditingController(text: widget.model.note);
    projectType = TextEditingController(text: widget.model.projectType);
    // handle splaiers list

    categorysController = TextEditingController(text: widget.model.category);
    Hive.box<AddFinancialModel>(kFinancialsBox).values.forEach((element) {
      splaiers.add(element.supplierName);
    });
    // handle categorys list
    Hive.box<AddFinancialModel>(kFinancialsBox).values.forEach((element) {
      categorys.add(element.category == "" ? "عام" : element.category!);
    });
    super.initState();
  }

  @override
  void dispose() {
    year.dispose();
    month.dispose();
    day.dispose();
    carance.dispose();
    projectState.dispose();
    splierName.dispose();
    noteController.dispose();
    projectType.dispose();
    categorysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const AddFundAppBar(
            title: "اجراء التعديلات",
            backBtn: false,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 11, left: 300, top: 8.0),
            child: Form(
              key: formKey,
              autovalidateMode: validateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CustomDropDown(
                          splaiers: categorys,
                          splierName: categorysController,
                          text: "المجموعة",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFormFeld(
                            controller: funantialNoController,
                            hintText: "رقم المعاملة",
                            inputType: TextInputType.number),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomDropDown(
                    initialValue: widget.model.supplierName,
                    splierName: splierName,
                    text: "اسم المورد",
                    splaiers: splaiers,
                  ),
                  const SizedBox(height: 8),
                  PriceRow(
                    controller: priceController,
                    caranceList: carrances,
                    carance: carance,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDatePiker(context, widget.model.pillDate)
                                .then((pickedDate) {
                              if (pickedDate != null) {
                                setState(() {
                                  dateTime = pickedDate;
                                });
                              }
                            });
                          },
                          icon: const Icon(Icons.date_range_outlined),
                          color: AppColor.secndaryColor,
                        ),
                        const Text(
                          "تاريخ الفاتورة",
                          style: TextStyles.bold16,
                        ),
                      ],
                    ),
                  ),
                  DateRow(
                    date: dateTime ?? widget.model.pillDate,
                    year: TextEditingController(
                        text: widget.model.pillDate.year.toString()),
                    month: TextEditingController(
                        text: widget.model.pillDate.month.toString()),
                    day: TextEditingController(
                        text: widget.model.pillDate.day.toString()),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: CustomOptionMenu(
                            controller: projectType,
                            optionsList: const [
                              'Project',
                              'Not Project',
                              'Suggested'
                            ],
                          )),
                      const CustomLablole(
                        txt: 'نوع المشروع ',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: CustomTextFormFeld(
                              controller: noteController,
                              hintText: "ملاحظات",
                              inputType: TextInputType.text,
                              validator: false),
                        ),
                      ),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: CustomOptionMenu(
                            controller: projectState,
                            noteController: noteController,
                            optionsList: const ['ارجاع', 'تسجيل', 'تحويل'],
                          )),
                      const CustomLablole(
                        txt: 'حالة المعاملة ',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SubmenuAddButton(
                    onSubmited: () {
                      if (formKey.currentState!.validate()) {}
                      widget.model.carance = carance.text;
                      widget.model.funantialNo = funantialNoController.text;
                      widget.model.note = noteController.text;
                      widget.model.pillDate = dateTime ?? widget.model.pillDate;
                      widget.model.price = priceController.text;
                      widget.model.projectState = projectState.text;
                      widget.model.projectType = projectType.text;
                      widget.model.supplierName = splierName.text;
                      widget.model.editFinancialDate = DateTime.now();
                      widget.model.category = categorysController.text; 
                      context.read<HomeCubit>().edit(widget.model);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
 if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            model.save();
            context.read<HomeCubit>().getAllData();
          }
*/