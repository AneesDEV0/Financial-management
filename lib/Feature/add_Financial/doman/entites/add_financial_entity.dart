// ignore_for_file: overridden_fields, annotate_overrides

import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';

class AddFinancialEntity {
  String funantialNo;
  String supplierName;
  String price;
  String carance;
  DateTime date;
  String projectType;
  String projectState;
  String? note;
  String? category;

  AddFinancialEntity(
      {required this.funantialNo,
      required this.supplierName,
      required this.price,
      required this.carance,
      required this.date,
      required this.projectType,
      required this.projectState,
      required this.category,
      required this.note});
}
