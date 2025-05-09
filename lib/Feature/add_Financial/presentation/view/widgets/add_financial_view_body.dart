import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/entites/add_financial_entity.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/custom_labole.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/price_row.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/widgets/submit_button.dart';
import 'package:edaray_applecation/core/helper_functions/show_error_bart.dart';
import 'package:edaray_applecation/core/utils/app_color.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:edaray_applecation/core/widgets/custom_textformfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../constants.dart';
import '../../../../../core/helper_functions/show_datepicker.dart';
import '../../../../Home/presentation/cubits/home/home_cubit.dart';
import '../../cubits/cubit/add_funantial_cubit.dart';
import 'add_app_bar.dart';
import 'custom_dropdown.dart';
import 'custom_optionmenu.dart';
import 'date_row.dart';

class AddFinancialViewBody extends StatefulWidget {
  const AddFinancialViewBody({super.key});

  @override
  State<AddFinancialViewBody> createState() => _AddFinancialViewBodyState();
}

class _AddFinancialViewBodyState extends State<AddFinancialViewBody> {
  DateTime? dateTime;
  late FocusNode noFocus,
      splaierFocus,
      priceFocus,
      caranceFocus,
      prTypeFocus,
      prStatusFocus,
      noteFocus;
  late TextEditingController year,
      month,
      day,
      carance,
      projectState,
      projectType,
      noteController,
      splierName,
      categorysController;
  late String funantialNo, price, note;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  List<String> carrances = ["NIS", "USD", "EUR"];
  List<String> projectStates = ['ارجاع', 'تسجيل', 'تحويل'];
  List<String> projectTypes = ['Project', 'Not Project', 'Suggested'];
  List<String> splaiers = [];
  List<String> categorys = [];
  late FocusScopeNode focusScopeNode; // Create a FocusScopeNode

  @override
  void initState() {
    focusScopeNode = FocusScopeNode(); // Initialize the FocusScopeNode

    // init Text Controllers
    year = TextEditingController();
    month = TextEditingController();
    day = TextEditingController();
    carance = TextEditingController();
    projectState = TextEditingController();
    splierName = TextEditingController();
    categorysController = TextEditingController();
    noteController = TextEditingController();
    projectType = TextEditingController();
    // init Focus Nodes
    noFocus = FocusNode();
    splaierFocus = FocusNode();
    priceFocus = FocusNode();
    caranceFocus = FocusNode();
    prTypeFocus = FocusNode();
    prStatusFocus = FocusNode();
    noteFocus = FocusNode();

    // handle splaiers list
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
    focusScopeNode.dispose(); // Don't forget to dispose the FocusScopeNode

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
    return BlocListener<AddFunantialCubit, AddFunantialState>(
      listener: (context, state) {
        if (state is AddFunantialSeuccess) {
          Navigator.pop(context);
          context.read<HomeCubit>().getAllData();
        }
        if (state is AddFunantialFailure) {
          buildErrorBar(context, state.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: FocusScope(
          node: focusScopeNode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const AddFundAppBar(
                title: "! اضافة معاملة جديدة",
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11, left: 300, top: 8.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: validateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomTextFormFeld(
                                  focusMode: noFocus,
                                  hintText: "رقم المعاملة",
                                  onSaved: (p0) {
                                    funantialNo = p0!;
                                  },
                                  onSubmit: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(splaierFocus);
                                  },
                                  inputType: TextInputType.number),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Center(
                              child: CustomDropDown(
                                splaiers: categorys,
                                splierName: categorysController,
                                text: "المجموعة",
                                onSelected: (p0) {
                                  priceFocus.requestFocus();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropDown(
                        focusMode: splaierFocus,
                        splierName: splierName,
                        text: "اسم المورد",
                        splaiers: splaiers,
                        onSelected: (_) {
                          // priceFocus.requestFocus();
                        },
                      ),
                      const SizedBox(height: 8),
                      PriceRow(
                        focusNode: priceFocus,
                        caranceList: carrances,
                        carance: carance,
                        onSaved: (p0) {
                          price = p0!;
                        },
                        onSubmit: (_) {
                          FocusScope.of(context).requestFocus(noteFocus);
                        },
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDatePiker(context, null).then((pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      prTypeFocus.requestFocus();

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
                        date: dateTime ?? DateTime.now(),
                        year: TextEditingController(
                            text: dateTime?.year.toString()),
                        month: TextEditingController(
                            text: dateTime?.month.toString()),
                        day: TextEditingController(
                            text: dateTime?.day.toString()),
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
                                optionsList: projectTypes,
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
                                  focusMode: noteFocus,
                                  controller: noteController,
                                  hintText: "ملاحظات",
                                  inputType: TextInputType.text,
                                  onSaved: (p0) {
                                    note = p0!;
                                  },
                                  validator: false),
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              height: 45,
                              child: CustomOptionMenu(
                                controller: projectState,
                                noteController: noteController,
                                optionsList: projectStates,
                                onSelected: (value) {
                                  if (value == "ارجاع") {
                                    noteController.text = "بسبب : ";
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    noteController.notifyListeners();
                                  }
                                  if (value == "تسجيل") {
                                    noteController.text = "";
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    noteController.notifyListeners();
                                  }
                                  noteFocus.requestFocus();
                                },
                              )),
                          const CustomLablole(
                            txt: 'حالة المعاملة ',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      SubmenuAddButton(onSubmited: () {
                        formKey.currentState!.validate();
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          AddFinancialEntity addFinancialEntity =
                              AddFinancialEntity(
                                  funantialNo: funantialNo,
                                  supplierName:
                                      splierName.text.replaceAll("أ", "ا"),
                                  price: price,
                                  carance: carance.text,
                                  date: dateTime!,
                                  projectType: projectType.text,
                                  projectState: projectState.text,
                                  category: categorysController.text,
                                  note: note);
                          if (splierName.text != '') {
                            context.read<HomeCubit>().focusNode.requestFocus();
                            context
                                .read<AddFunantialCubit>()
                                .addAddFinancial(addFinancialEntity);
                          } else {
                            buildErrorBar(context, "الرجاء ادخال اسم المورد");
                          }
                        } else {
                          validateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
