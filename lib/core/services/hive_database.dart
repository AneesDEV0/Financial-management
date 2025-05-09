
import 'package:edaray_applecation/core/services/database_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Feature/add_Financial/data/model/add_financial_model.dart';

class HiveDatabase implements DatabaseService {
  @override
  addData(AddFinancialModel model, String boxName) {
    try {
      var noteBox = Hive.box<AddFinancialModel>(boxName);
      var clonedModel = (model).copyWith();

      noteBox.add(clonedModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  List<T> getAddData<T>(String boxName) {
    try {
      var noteBox = Hive.box<T>(boxName);
      return noteBox.values.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
