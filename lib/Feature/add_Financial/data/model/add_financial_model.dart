import 'package:edaray_applecation/Feature/add_Financial/doman/entites/add_financial_entity.dart';
import 'package:hive/hive.dart';

part 'add_financial_model.g.dart';

@HiveType(typeId: 0)
class AddFinancialModel extends HiveObject {
  @HiveField(0)
  String funantialNo;
  @HiveField(1)
  String supplierName;
  @HiveField(2)
  String price;
  @HiveField(3)
  String carance;
  @HiveField(4)
  DateTime pillDate;
  @HiveField(5)
  DateTime financialDate;
  @HiveField(6)
  String projectType;
  @HiveField(7)
  String projectState;
  @HiveField(8)
  String? note;
  @HiveField(9)
  DateTime editFinancialDate;
  @HiveField(10)
  String? category;

  AddFinancialModel(
      {required this.funantialNo,
      required this.supplierName,
      required this.price,
      required this.carance,
      required this.pillDate,
      required this.financialDate,
      required this.projectType,
      required this.projectState,
      required this.note,
      required this.editFinancialDate,
      required this.category});

  factory AddFinancialModel.fromEntity(AddFinancialEntity entity) {
    return AddFinancialModel(
        funantialNo: entity.funantialNo,
        supplierName: entity.supplierName,
        price: entity.price,
        carance: entity.carance,
        pillDate: entity.date,
        financialDate: DateTime.now(),
        projectType: entity.projectType,
        projectState: entity.projectState,
        note: entity.note,
        editFinancialDate: DateTime.now(),
        category: entity.category == "" ? 'عام' : entity.category!);
  }
  // to json
  factory AddFinancialModel.fromJson(Map<String, dynamic> json) {
    return AddFinancialModel(
      funantialNo: json['funantialNo'],
      supplierName: json['supplierName'],
      price: json['price'],
      carance: json['carance'],
      pillDate: DateTime.parse(json['pillDate']),
      financialDate: DateTime.parse(json['financialDate']),
      projectType: json['projectType'],
      projectState: json['projectState'],
      note: json['note'],
      editFinancialDate: DateTime.parse(json['editFinancialDate']),
      category: json['category'],
    );
  }
  // toJson
  Map<String, dynamic> toJson() {
    return {
      'funantialNo': funantialNo,
      'supplierName': supplierName,
      'price': price,
      'carance': carance,
      'pillDate': pillDate.toIso8601String(),
      'financialDate': financialDate.toIso8601String(),
      'projectType': projectType,
      'projectState': projectState,
      'note': note,
      'editFinancialDate': editFinancialDate.toIso8601String(),
      'category': category ?? "عام",
    };
  }

  // CopyWith method for creating a new instance
  AddFinancialModel copyWith({
    String? funantialNo,
    String? supplierName,
    String? price,
    String? carance,
    DateTime? pillDate,
    DateTime? financialDate,
    String? projectType,
    String? projectState,
    String? note,
    DateTime? editFinancialDate,
  }) {
    return AddFinancialModel(
      funantialNo: funantialNo ?? this.funantialNo,
      supplierName: supplierName ?? this.supplierName,
      price: price ?? this.price,
      carance: carance ?? this.carance,
      pillDate: pillDate ?? this.pillDate,
      financialDate: financialDate ?? this.financialDate,
      projectType: projectType ?? this.projectType,
      projectState: projectState ?? this.projectState,
      note: note ?? this.note,
      category: category ?? this.note,
      editFinancialDate: editFinancialDate ?? this.editFinancialDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddFinancialModel &&
          runtimeType == other.runtimeType &&
          funantialNo == other.funantialNo &&
          supplierName == other.supplierName;

  @override
  int get hashCode => funantialNo.hashCode;
}
